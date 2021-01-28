" vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
source ~/.config/nvim/configs/plugins/themes.vim
source ~/.config/nvim/configs/plugins/undotree.vim
source ~/.config/nvim/configs/plugins/git.vim
source ~/.config/nvim/configs/plugins/fzf.vim
source ~/.config/nvim/configs/plugins/polyglot.vim
source ~/.config/nvim/configs/plugins/mucomplete.vim
source ~/.config/nvim/configs/plugins/ale.vim

" Black for python (code formatter) format all the buffer with :call Black()
if hostname() !~? 'admin.*'
    Plug 'a-vrma/black-nvim', {'do': ':UpdateRemotePlugins'}
endif

call plug#end()
