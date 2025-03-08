vim.loader.enable()
_G.Config = {
  notes_dir = "~/Syncthing/SYNC_STUFF/notes/notes",
}

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
require("mini.deps").setup({ job = { n_threads = 4 } })

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

add({ name = "mini.nvim" })
vim.cmd("colorscheme mininord")

require("aorith.plugins.mini.basics")
require("aorith.plugins.mini.notify")
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.tabline").setup()
require("aorith.plugins.mini.statusline")
require("mini.extra").setup()
require("mini.diff").setup({ view = { style = "sign" } })
require("mini.git").setup({ command = { split = "vertical" } })
require("aorith.plugins.mini.files")
require("aorith.plugins.mini.hipatterns")

later(function()
  require("mini.misc").setup({ make_global = { "put", "put_text" } })
  MiniMisc.setup_auto_root()
end)
later(function() require("mini.ai").setup() end) -- Enables 'ciq' (change inside quotes) or 'cib' (change inside brackets), etc.
later(function() require("mini.bufremove").setup() end)
-- later(require("mini.cursorword").setup)
later(function() require("aorith.plugins.mini.indentscope") end)
-- sa => surround around
-- sd => surround delete
-- sr => surround replace
-- Example: Visual select a word -> sa"  (surround around quotes, 'saq' with mini.ai)
later(function() require("mini.surround").setup() end)
later(function() require("mini.visits").setup() end)
later(function() require("aorith.plugins.mini.pick") end)
later(function() require("aorith.plugins.mini.clue") end)
later(function() require("aorith.plugins.mini.completion") end)
later(function() require("mini.jump").setup({ delay = { highlight = 50 } }) end)
later(
  -- Press CR to start jumping
  function() require("mini.jump2d").setup({ labels = "abcdefghijklmnopqrstu1234vwxyz", allowed_lines = { blank = false, cursor_at = false, fold = false } }) end
)
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
  add({ source = "nvim-treesitter/nvim-treesitter-textobjects" })

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
