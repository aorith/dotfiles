vim.loader.enable()

--- Bootstrap 'mini.deps'
-------------------------------------------------------------------------------
local mini_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { "git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
require("mini.deps").setup()

--- Core configuration
-------------------------------------------------------------------------------
require("aorith.core.options")
require("aorith.core.mappings")
require("aorith.core.commands")
require("aorith.core.autocmds")

--- Mini nvim
-------------------------------------------------------------------------------
local add, later = MiniDeps.add, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or later

add({ name = "mini.nvim", checkout = "HEAD" })
require("aorith.plugins.theme")

require("aorith.plugins.mini.basics").setup()
require("aorith.plugins.mini.notify").setup()
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.tabline").setup()
require("aorith.plugins.mini.statusline").setup()
require("mini.extra").setup()
require("mini.diff").setup({ view = { style = "sign" } })
require("mini.git").setup({ command = { split = "vertical" } })
require("mini.jump").setup({ delay = { highlight = 50 } })
require("aorith.plugins.mini.files").setup()

later(require("mini.misc").setup)
later(require("mini.ai").setup) -- Enables 'ciq' (change inside quotes) or 'cib' (change inside brackets), etc.
later(require("mini.bufremove").setup)
-- later(require("mini.cursorword").setup)
later(require("aorith.plugins.mini.indentscope").setup)
-- sa => surround around
-- sd => surround delete
-- sr => surround replace
-- Example: Visual select a word -> sa"  (surround around quotes, 'saq' with mini.ai)
later(require("mini.surround").setup)
later(require("mini.visits").setup)
later(require("aorith.plugins.mini.pick").setup)
later(require("aorith.plugins.mini.hipatterns").setup)
later(require("aorith.plugins.mini.clue").setup)
later(require("aorith.plugins.mini.completion").setup)

--- Plugins
-------------------------------------------------------------------------------
add({ source = "tpope/vim-sleuth" })
-- add({ source = "kcl-lang/kcl.nvim" })

-- Treesitter
now_if_args(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "master",
    hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
  })
  add({ source = "nvim-treesitter/nvim-treesitter-context" })

  require("aorith.plugins.treesitter")
end)

-- Nvim-Lspconfig
now_if_args(function()
  add({ source = "neovim/nvim-lspconfig" })
  require("aorith.plugins.lsp")
end)

-- Formatting
later(function()
  add({ source = "stevearc/conform.nvim" })
  require("aorith.plugins.formatting")
end)

-- Linting
later(function()
  add({ source = "mfussenegger/nvim-lint" })
  require("aorith.plugins.linting")
end)

-- Outline
later(function()
  add({ source = "hedyhli/outline.nvim" })
  require("aorith.plugins.outline")
end)

-- Neotree
later(function()
  add({
    source = "nvim-neo-tree/neo-tree.nvim",
    name = "neo-tree",
    depends = {
      { source = "nvim-lua/plenary.nvim", name = "plenary" },
      { source = "MunifTanjim/nui.nvim", name = "nui" },
    },
  })
  require("aorith.plugins.neotree")
end)

-- Mason
later(function()
  add({
    source = "williamboman/mason.nvim",
    hooks = { post_checkout = function() vim.cmd("MasonUpdate") end },
  })
  require("aorith.plugins.mason")
end)
