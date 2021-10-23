" python
" select lines + gq
" full document with gggqG
setlocal formatprg=autopep8\ -
setlocal sts=4 sw=4 expandtab

if !exists("g:my_black_function_loaded")
  function! s:Black()
    if &filetype == "python"
      if &mod == 0
        execute ":!python3 -m black --line-length 80 " . resolve(expand('%:p'))
      else
        echohl ErrorMsg
        echomsg "Sorry, buffer has been modified. Save it first."
        echohl None
      endif
    else
      echohl ErrorMsg
      echomsg "Aborting, filetype is not python"
      echohl None
    endif
  endfunction

  function! s:BlackDiff()
    if &filetype == "python"
      if &mod == 0
        " the character '#' is replaced by the filename
        :vnew | setlocal ft=diff buftype=nofile bufhidden=hide colorcolumn=0 noswapfile | r !python3 -m black --line-length 80 --quiet --diff #
      else
        echohl ErrorMsg
        echomsg "Sorry, buffer has been modified. Save it first."
        echohl None
      endif
    else
      echohl ErrorMsg
      echomsg "Aborting, filetype is not python"
      echohl None
    endif
  endfunction

  let g:my_black_function_loaded = 1
endif
command! Black call s:Black()
command! BlackDiff call s:BlackDiff()
