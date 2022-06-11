setlocal nospell
setlocal spelllang=en,es
" setlocal foldlevel=2
setlocal conceallevel=1
setlocal formatoptions=jnlq " or vim-polyglot will override this
setlocal synmaxcol=0 " remove syntax coloring limit

" https://vi.stackexchange.com/questions/365/is-it-possible-to-use-two-different-color-backgrounds-in-a-single-vim-buffer
function! ColorCodeBlocks() abort
  setlocal signcolumn=no

  sign define codeblock linehl=codeBlockBackground

  augroup code_block_background
    autocmd! * <buffer>
    autocmd InsertLeave  <buffer> call s:place_signs()
    autocmd BufEnter     <buffer> call s:place_signs()
    autocmd BufWritePost <buffer> call s:place_signs()
  augroup END
endfunction

function! s:place_signs()
  let l:continue = 0
  let l:file = expand('%')

  execute 'sign unplace * file=' . l:file

  for l:lnum in range(1, line('$'))
    let l:line = getline(l:lnum)
    if l:continue || l:line =~# '^\s*```'
      execute printf('sign place %d line=%d name=codeblock file=%s',
            \ l:lnum, l:lnum, l:file)
    endif

    let l:continue = l:continue
          \ ? l:line !~# '^\s*```$'
          \ : l:line =~# '^\s*```'
  endfor
endfunction

highlight codeBlockBackground ctermbg=black
call ColorCodeBlocks()

if expand('%:p') =~# expand($MY_NOTES_DIR)
  " Alternates between markdown links '[name](path)' ...
  " note that `let @/ = ''` clears the last search
  nnoremap <silent> <TAB> $/[.\+\](<CR>:let @/ = ''<CR>0f[

  " Opens markdown link under cursor with 'gF'
  nnoremap <silent> <CR> :call aorith#markdown#navigateLink()<CR>
endif
