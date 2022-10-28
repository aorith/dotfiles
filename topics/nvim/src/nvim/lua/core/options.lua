local opt = vim.opt
local g = vim.g

-- disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- leader
g.mapleader = " "
g.maplocalleader = " "

vim.cmd([[
filetype plugin indent on
syntax enable
]])

opt.termguicolors = true
opt.encoding = "utf-8"
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.cindent = true
opt.smarttab = true
opt.hlsearch = true
opt.incsearch = true
opt.wrap = false
opt.linebreak = true
opt.breakindent = false
opt.showbreak = "↳ "
opt.wrapscan = true
opt.timeoutlen = 250
opt.cmdheight = 1
opt.splitright = true
opt.mouse = "a"
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.formatoptions = "jnlq"
opt.shortmess = "atToOFc" -- Prompt message options
opt.cursorline = true -- Highlight cursor line
opt.cursorlineopt = "number"
opt.wildmode = { "list", "longest" } -- Command-line completion mode
opt.signcolumn = "yes:2" -- Show sign column - max N signs
vim.cmd([[
    set cinkeys-=0# " dont indent '#'
    set indentkeys-=0#
]])
opt.updatetime = 400 -- For CursorHold and swapfile
opt.report = 0 -- Always report the number of lines changed after :command

opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Do not ignore case with capitals

opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context

opt.fillchars:append({
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┨",
  vertright = "┣",
  verthoriz = "╋",
})

opt.showmode = false -- don't show mode - it's shown in the statusline

opt.swapfile = true
opt.backup = true
opt.undofile = true

-- directory configuration
vim.cmd([[
set viminfo+=n~/.local/share/nvim/viminfo
set undodir=~/.local/share/nvim/undodir//
set undolevels=1000 undoreload=10000
set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//
]])

-- others
vim.cmd([[
" highligh extra whitespaces
match ErrorMsg '\s\+$'
augroup aorith_autocmds
    autocmd!
    " Last position without centered cursor
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " For large files
    "autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax sync clear | endif
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME', -1)
augroup end
]])

vim.cmd([[
map <F1> <nop>
map! <F1> <nop>
command! W w
command! Q q
]])
