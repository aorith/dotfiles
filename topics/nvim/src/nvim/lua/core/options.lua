vim.keymap.set("n", "<Space>", "<nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- TODO: neovim 0.9: https://github.com/neovim/neovim/commit/04fbb1de4488852c3ba332898b17180500f8984e
-- :h diff  & enable linematch
if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
  vim.cmd("set diffopt+=linematch:50")
end

--opt.background = require("core.utils").os_background()

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.autoindent = true
vim.opt.cmdheight = 0
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.confirm = true -- confirm to save changes before exiting a modified buffer
vim.opt.cursorline = true -- Highlight cursor line
vim.opt.cursorlineopt = "number"
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.formatoptions = "jnlq"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.hlsearch = true
vim.opt.ignorecase = true -- Ignore case
vim.opt.incsearch = true
vim.opt.laststatus = 0
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumblend = 0 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.relativenumber = true
vim.opt.report = 0 -- Always report the number of lines changed after :command
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.shiftwidth = 4
vim.opt.shortmess:append({ W = true, I = true, c = true })
vim.opt.showbreak = "↳ "
vim.opt.showmode = false -- don't show mode - it's shown in the statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes" -- Show sign column, "yes:3" max 3 signs
vim.opt.smartcase = true -- Do not ignore case with capitals
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = -1
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.title = true
vim.opt.updatetime = 200 -- For CursorHold and swapfile
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false
vim.opt.wrapscan = true

vim.opt.undolevels = 10000
vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.undofile = true

-- characters used in the splits
vim.opt.fillchars:append({
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
})

-- directory configuration
vim.cmd([[
set viminfo+=n~/.local/share/nvim/viminfo
set undodir=~/.local/share/nvim/undodir//
set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//
]])

-- others
vim.cmd([[
map <F1> <nop>
map! <F1> <nop>
command! W w
command! Q q
]])

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
