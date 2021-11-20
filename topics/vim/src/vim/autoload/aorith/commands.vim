if exists('g:loaded_my_commands')
  finish
endif
let g:loaded_my_commands = 1

function aorith#commands#bat(...) abort
  if !executable('bat')
    echoerr 'Executable for "bat" not found.'
    return
  endif
  if a:0 == 0 || empty(a:000[0])
    let l:source = expand('%')
  else
    let l:source = a:000[0]
  endif
  if !empty(l:source)
    let l:file = shellescape(l:source)
  endif

  execute '!env LESS="-iMRX" bat ' . l:file
endfunction
