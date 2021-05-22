lua << EOF
vim.g.tokyonight_style = "night"

vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_dark_sidebar	= true
vim.g.tokyonight_dark_float = true

vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_italic_functions = false

vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_hide_inactive_statusline = 0

vim.g.tokyonight_transparent = 0

vim.cmd[[colorscheme tokyonight]]
EOF

