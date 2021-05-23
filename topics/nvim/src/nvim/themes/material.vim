set termguicolors

lua << EOF
vim.g.material_style = 'darker'
vim.g.material_italic_comments = false
vim.g.material_italic_keywords = false
vim.g.material_italic_functions = false
vim.g.material_italic_variables = false
vim.g.material_contrast = true
vim.g.material_borders = true
vim.g.material_disable_background = false
require('material').set()
EOF

colorscheme material
