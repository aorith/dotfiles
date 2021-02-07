" Black for python (code formatter) format all the buffer with :Black
Plug 'a-vrma/black-nvim', {'do': ':UpdateRemotePlugins'}
command! -nargs=0 Black call Black()
