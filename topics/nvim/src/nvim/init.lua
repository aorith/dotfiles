---------------- HELPERS  ---------------------------------------------------------

local api = vim.api  -- TODO (documentar qué hace)
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- Set options
local wo = vim.wo    -- Set window-scoped options (vim.wo.number = true)
local fmt = string.format -- TODO (documentar qué hace)

-- Map helper function
-- example:
-- map('', '<leader>c', '"+y') -- Copy to clipboard in normal, visual, select and operator modes
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

---------------- PLUGINS  ---------------------------------------------------------

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  cmd 'packadd packer.nvim'
end

require('plugins')

---------------- PLUGIN CONFIGURATION  --------------------------------------------

-- LSP
local nvim_lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'

--  Nvim-Cmp
local nvim_cmp = require 'cmp'

nvim_cmp.setup {
  snippet = {
    expand = function(args)
      fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = nvim_cmp.mapping.select_prev_item(),
    ['<C-n>'] = nvim_cmp.mapping.select_next_item(),
    ['<C-d>'] = nvim_cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = nvim_cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = nvim_cmp.mapping.complete(),
    ['<C-e>'] = nvim_cmp.mapping.close(),
    ['<CR>'] = nvim_cmp.mapping.confirm {
      behavior = nvim_cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

-- Treesitter
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-- supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

nvim_lsp.pylsp.setup {
  settings = {
    pylsp = {
      enabled = true,
      plugins = {
        pycodestyle = {
          enabled = true,
          ignore = { "E501" },
        },
        pylint = { enabled = false },
      }
    }
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list

map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

-- Black
cmd "let g:black#settings = { 'line_length': 100 }"

-- Indents lukas-reineke/indent-blankline.nvim
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = false,
}

---------------- OPTIONS  ---------------------------------------------------------

local maxwidth = 84

cmd 'colorscheme desert'            -- Fallback colorscheme
cmd 'auto BufEnter * let &titlestring = hostname() . "/" . "%t"' -- Titlestring TODO
opt.colorcolumn = tostring(maxwidth)-- Line length marker
opt.textwidth = maxwidth               -- Maximum width of text
opt.cursorline = true               -- Highlight cursor line
opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options
opt.shortmess = 'atToOFc'           -- Prompt message options
opt.pumheight = 12                  -- Max height of popup menu
opt.signcolumn = 'yes'              -- Show sign column
opt.formatoptions = 'crqnj'         -- Automatic formatting options
opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
opt.ignorecase = true               -- Ignore case
opt.joinspaces = false              -- No double spaces with join
opt.list = false                    -- Show some invisible characters
opt.listchars = {
  space = '·', tab = '▸ ', eol = '↴',
  extends = '→', precedes = '←'
}
opt.number = true                   -- Show line numbers
opt.relativenumber = false          -- Relative line numbers
opt.scrolloff = 4                   -- Lines of context
opt.shiftround = true               -- Round indent
opt.shiftwidth = 2                  -- Size of an indent
opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
opt.splitbelow = true               -- Put new windows below current
opt.splitright = true               -- Put new windows right of current
opt.tabstop = 4                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.pastetoggle = '<F2>'            -- Paste mode
opt.updatetime = 100                -- NOTE: this affects swapfile, see :h updatetime
opt.swapfile = false                -- Don't use a swapfile
opt.undofile = true                 -- Turn on undofile/dir
-- directory configuration
cmd 'set viminfo+=n~/.local/share/nvim/viminfo'
cmd 'set undodir=~/.local/share/nvim/undodir//'
cmd 'set undolevels=1000 undoreload=10000'
cmd 'set backupdir=~/.local/share/nvim/backup//'
cmd 'set directory=~/.local/share/nvim/swap//'

--Remap space as leader key
api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
g.mapleader = ' '
g.maplocalleader = ' '

-- Make :Q and :W behave just like :q and :w
cmd 'command! W w'
cmd 'command! Q q'

---------------- MAPS  ------------------------------------------------------------

map('n', '<leader>y', 'V:OSCYank<CR>')
map('v', '<leader>y', ':OSCYank<CR>')

map('n', '<leader>h', ':wincmd h<CR>')
map('n', '<leader>j', ':wincmd j<CR>')
map('n', '<leader>k', ':wincmd k<CR>')
map('n', '<leader>l', ':wincmd l<CR>')

-- FZF, search files in current directory
map('', '<C-f>', '<Esc><Esc>:Files<CR>')
-- FZF, search inside the document if we are in insert mode
map('i', '<C-f>', '<Esc><Esc>:BLines<CR>')

-- Current file commits
map('', '<C-g>', '<Esc><Esc>:BCommits<CR>')
-- All commits
map('', '<leader>G', '<Esc><Esc>:Commits<CR>')
-- Show commit from current line
map('', '<leader>g', ':GitMessenger<CR>')

-- Show current buffers
map('n', '<leader>b', ':Buffers<CR>')

-- Go to next buffer
map('n', '<leader><TAB>', ':bnext<CR>')

-- List toggle (without the 'map' helper function)
api.nvim_set_keymap('', '<F3>', '<Esc><Esc>:set list!<CR>',
  { noremap = true, silent = true })

-- Format python code with :Black
cmd 'command Black :call Black()<CR>'

---------------- THEMES -----------------------------------------------------------

local function paste_mode()
  if api.nvim_eval('&paste > 0') == 0 then
    return ""
  else
    return "PASTE"
  end
end

local function is_readonly()
  if api.nvim_eval('&readonly > 0') == 0 then
    return ""
  else
    return "RO"
  end
end

local function ascii_under_cursor()
  return string.match(api.nvim_exec('ascii', true), "(.-),")
end

require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {
      {paste_mode, color = {fg = '#fafafa', bg = '#a61212'}},
      'mode'
    },
    lualine_b = {'branch'},
    lualine_c = {
      {is_readonly, color = {fg = '#a61212', bg = '#fafafa'}},
      'filename'
    },
    lualine_x = {{ascii_under_cursor}, 'filetype', 'encoding', 'fileformat'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  --inactive_sections = {},
  --tabline = {},
  --extensions = {}
}

--[[
-- Github theme
require("github-theme").setup({
  theme_style = "dark",
})
--]]

-- Gruvbox
--cmd 'colorscheme gruvbox'

-- Dynamic theme
require 'dynamic'
