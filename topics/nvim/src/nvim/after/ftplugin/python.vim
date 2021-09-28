" python
" select lines + gq
" full document with gggqG
setlocal formatprg=autopep8\ -
setlocal sts=4 sw=4 expandtab

if !exists("g:my_black_function_loaded")
  function! s:Black()
    execute ":!python3 -m black " . resolve(expand('%:p'))
  endfunction
  let g:my_black_function_loaded = 1
endif
command! Black call s:Black()
