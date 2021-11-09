" Generate a statusline flag for expandtab.
function! ExpandTabFlag()
  if &expandtab == 0
    return ''
  else
    return 'X'
  endif
endfunction

" Generate statusline flags for softtabstop, tabstop, and shiftwidth.
function! TabStopStatus()
  let str = "T:" . &tabstop
  " Show softtabstop or shiftwidth if not equal tabstop
  if (&softtabstop && (&softtabstop != &tabstop)) || (&shiftwidth  && (&shiftwidth  != &tabstop))
    let str = "TS:" . &tabstop
    if &softtabstop
      let str = str . "\ STS:" . &softtabstop
    endif
    if &shiftwidth != &tabstop
      let str = str . "\ SW:" . &shiftwidth
    endif
  endif
  return str
endfunction

set statusline=
set statusline+=%#error#%{&paste?'\ \ PASTE\ ':''}
set statusline+=%#error#%m%* " modified flag
set statusline+=\ %#error#%r%* " readonly flag
set statusline+=\%y " filetype
set statusline+=[%{strlen(&fenc)?&fenc:'none'},%{&ff}] "file encoding / filetype
set statusline+=\ %f " F=fullpath of current file;  f=relative path

" right side
set statusline+=%=

"set statusline+=[
"set statusline+=%{ExpandTabFlag()}
"set statusline+=%{TabStopStatus()}
"set statusline+=]
set statusline+=\[%l:%c/  " line:column  (%L for total lines)
set statusline+=%p%%] " percent of the document
set statusline+=\[ASCII:%3b] " ASCII under cursor
"set statusline+=\[B:%n] " buffer number
