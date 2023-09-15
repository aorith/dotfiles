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

-- persistent undo
opt.undofile = true
-- don't backup while overwritting the file
opt.backup = false
opt.writebackup = false

-- encoding and ff
opt.encoding = "utf8"
opt.fileformats = "unix,dos,mac"

-- filetype plugins
vim.cmd("filetype plugin indent on")
-- syntax
if vim.fn.exists("syntax_on") ~= 1 then
  vim.cmd("syntax enable")
end

-- misc
opt.cinkeys:remove("0#") -- don't reindent on # char
opt.completeopt = "menuone,noinsert,noselect"
opt.confirm = true -- confirm to save changes before exiting a modified buffer
opt.diffopt:append({ "linematch:60" }) -- better diff: https://github.com/neovim/neovim/pull/14537
opt.formatoptions = "qjl1" -- don't format comments
opt.history = 50 -- remember 50 items in cmd history
opt.laststatus = 2
opt.mouse = "a"
opt.number = true
opt.report = 0 -- Always report the number of lines changed after :command
opt.ruler = false
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmatch = true
opt.showmode = false -- don't show mode - it's shown in the statusline
opt.signcolumn = "yes" -- Show sign column, "yes:3" max 3 signs
opt.virtualedit = "block" -- Allow going past the end of line in visual block mode
opt.winminwidth = 5 -- Minimum window width

-- extra ui options
opt.pumblend = 5
opt.pumheight = 10
opt.winblend = 5

-- context
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context

-- list chars
opt.list = false
opt.listchars = {
  tab = ">-",
  trail = "·",
  nbsp = "␣",
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
opt.infercase = true
opt.smartcase = true -- Disable ignorecase when the search term contains upper case characters

-- tabs and indent
opt.autoindent = true
opt.breakindent = true -- indent wrapped lines to match line start
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = -1
opt.tabstop = 4

-- timers
opt.timeout = true
opt.timeoutlen = 500
opt.updatetime = 250 -- For CursorHold and swapfile

-- wrap
opt.wrap = false
opt.showbreak = "↳ "

-- splits
opt.splitkeep = "screen"
opt.splitright = true
opt.splitbelow = true

-- splits and other chars
opt.fillchars:append({
  fold = "╌",
  horiz = "═",
  horizup = "╩",
  horizdown = "╦",
  vert = "║",
  vertleft = "╣",
  vertright = "╠",
  verthoriz = "╬",
})

-- folds
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 1 -- Display all folds except top ones
opt.foldnestmax = 10 -- Create folds only for some number of nested levels
opt.foldlevelstart = 99 -- Start with all folds open

-- grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
