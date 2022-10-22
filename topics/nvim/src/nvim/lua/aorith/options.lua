-- disable netrw in favor of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd [[
filetype plugin indent on
syntax enable
]]

vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.shiftround = true               -- Round indent
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.timeoutlen = 250
vim.opt.cmdheight = 1
vim.opt.mouse = "a"
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
vim.opt.shortmess = 'atToOFc'           -- Prompt message options
vim.opt.cursorline = true               -- Highlight cursor line
vim.opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
vim.opt.signcolumn = 'yes:2'            -- Show sign column - max N signs
vim.cmd [[
    set cinkeys-=0# " dont indent '#'
    set indentkeys-=0#
]]
vim.opt.updatetime = 400                -- For CursorHold and swapfile

vim.opt.ignorecase = true               -- Ignore case
vim.opt.smartcase = true                -- Do not ignore case with capitals

vim.opt.scrolloff = 4                   -- Lines of context
vim.opt.sidescrolloff = 8               -- Columns of context

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.undofile = true

-- directory configuration
vim.cmd [[
set viminfo+=n~/.local/share/nvim/viminfo
set undodir=~/.local/share/nvim/undodir//
set undolevels=1000 undoreload=10000
set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//
]]

-- others
vim.cmd [[
" highligh extra whitespaces
match ErrorMsg '\s\+$'
augroup aorith_autocmds
    autocmd!
    " Last position without centered cursor
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " For large files
    "autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax sync clear | endif
augroup end
]]

vim.cmd [[
map <F1> <nop>
map! <F1> <nop>
command! W w
command! Q q
]]
