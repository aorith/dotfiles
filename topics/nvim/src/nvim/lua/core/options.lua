local opt = vim.opt
local g = vim.g

-- TODO: neovim 0.9: https://github.com/neovim/neovim/commit/04fbb1de4488852c3ba332898b17180500f8984e
-- :h diff  & enable linematch

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
opt.breakindent = true
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
opt.signcolumn = "yes:3" -- Show sign column - max N signs
vim.cmd([[
    set cinkeys-=0# " dont indent '#'
    set indentkeys-=0#
]])
opt.updatetime = 320 -- For CursorHold and swapfile
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
map <F1> <nop>
map! <F1> <nop>
command! W w
command! Q q
]])

-- python3
local virtual_env_dir = vim.fn.getenv("HOME") .. "/.local/venvs/nvim"
if vim.fn.empty(vim.fn.glob(virtual_env_dir)) > 0 then
	vim.notify(
		"nvim virtual-env not present ('" .. virtual_env_dir .. "'), create it with 'py-env nvim' and install pynvim.",
		vim.log.levels.WARN
	)
else
	vim.g.python_host_prog = virtual_env_dir .. "/bin/python"
	vim.g.python3_host_prog = virtual_env_dir .. "/bin/python"
end

-- Disable builtin plugins
g.loaded_2html_plugin = 1
g.loaded_bugreport = 1
g.loaded_compiler = 1
g.loaded_ftplugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logipat = 1
g.loaded_matchit = 1
g.loaded_netrw = 1
g.loaded_netrwFileHandlers = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_optwin = 1
g.loaded_rplugin = 1
g.loaded_rrhelper = 1
g.loaded_spellfile_plugin = 1
g.loaded_synmenu = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_tutor = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
