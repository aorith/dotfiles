local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- TODO: neovim 0.9: https://github.com/neovim/neovim/commit/04fbb1de4488852c3ba332898b17180500f8984e
-- :h diff  & enable linematch
if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
  vim.cmd("set diffopt+=linematch:50")
end

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.autoindent = true
opt.cmdheight = 0
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true -- confirm to save changes before exiting a modified buffer
opt.cursorline = true -- Highlight cursor line
opt.cursorlineopt = "number"
opt.encoding = "utf-8"
opt.expandtab = true
opt.formatoptions = "jnlq"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.hlsearch = true
opt.ignorecase = true -- Ignore case
opt.incsearch = true
opt.laststatus = 0
opt.linebreak = true
opt.list = true
opt.mouse = "a"
opt.number = true
opt.pumblend = 0 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true
opt.report = 0 -- Always report the number of lines changed after :command
opt.scrolloff = 4 -- Lines of context
opt.shiftwidth = 4
opt.shortmess:append({ W = true, I = true, c = true })
opt.showbreak = "↳ "
opt.showmode = false -- don't show mode - it's shown in the statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Show sign column, "yes:3" max 3 signs
opt.smartcase = true -- Do not ignore case with capitals
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = -1
opt.splitright = true
opt.tabstop = 4
opt.termguicolors = true
opt.timeoutlen = 300
opt.title = true
opt.updatetime = 200 -- For CursorHold and swapfile
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false
opt.wrapscan = true

opt.undolevels = 10000
opt.swapfile = true
opt.backup = true
opt.undofile = true

-- characters used in the splits
opt.fillchars:append({
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
