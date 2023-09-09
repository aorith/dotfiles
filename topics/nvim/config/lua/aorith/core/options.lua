local nvim_appname = require("aorith.core.utils").nvim_appname
local g = vim.g
local opt = vim.opt

-- leader
g.mapleader = " "
g.maplocalleader = ","

-- Ensure nomodelineexpr
opt.modelineexpr = false

-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Disable some providers
g.loaded_perl_provider = 1
g.loaded_python3_provider = 1
g.loaded_node_provider = 1
g.loaded_ruby_provider = 1

-- Some more disables
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_tutor = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1

-- backup, swap and directory configuration
opt.viminfo:append("n" .. vim.fn.getenv("HOME") .. "/.local/share/" .. nvim_appname .. "/viminfo")
opt.undofile = true
opt.undodir = vim.fn.getenv("HOME") .. "/.local/share/" .. nvim_appname .. "/undodir//"
opt.backup = true
opt.backupdir = vim.fn.getenv("HOME") .. "/.local/share/" .. nvim_appname .. "/backup//"
opt.swapfile = true
opt.directory = vim.fn.getenv("HOME") .. "/.local/share/" .. nvim_appname .. "/swap//"

-- encoding and ff
opt.encoding = "utf8"
opt.fileformats = "unix,dos,mac"

-- misc
opt.cinkeys:remove("0#") -- don't reindent on # char
opt.confirm = true -- confirm to save changes before exiting a modified buffer
opt.diffopt:append({ "linematch:50" }) -- better diff: https://github.com/neovim/neovim/pull/14537
opt.formatoptions = "qjl"
opt.mouse = "a"
opt.number = true
opt.report = 0 -- Always report the number of lines changed after :command
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- don't show mode - it's shown in the statusline
opt.winminwidth = 5 -- Minimum window width
vim.wo.signcolumn = "yes" -- Show sign column, "yes:3" max 3 signs
opt.showmatch = true
opt.laststatus = 3

-- context
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context

-- list chars
opt.list = false
opt.listchars = {
  tab = ">-",
  trail = "·",
  nbsp = "+",
  extends = "…",
  precedes = "…",
}

-- cursorline
opt.cursorline = true -- Highlight cursor line
opt.cursorlineopt = "number" --only highlight the number

-- search
opt.hlsearch = true
opt.ignorecase = true -- Ignore case
opt.incsearch = true
opt.smartcase = true -- Disable ignorecase when the search term contains upper case characters

-- tabs and indent
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = -1
opt.tabstop = 4

-- timers
opt.timeout = true
opt.timeoutlen = 400
opt.updatetime = 300 -- For CursorHold and swapfile

-- wrap
opt.wrap = false
opt.showbreak = "↳ "

-- splits
opt.splitkeep = "screen"
opt.splitright = true
opt.splitbelow = true
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

-- grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
