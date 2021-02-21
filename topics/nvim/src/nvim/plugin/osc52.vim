" vim: ft=vim

if exists('g:loaded_osc52')
  finish
endif
let g:loaded_osc52 = 1

" Send a string to the terminal's clipboard using OSC52.
function! YankOSC52(str)
  let length = strlen(a:str)
  let limit = 100000
  let osc52_key = 'default'

  if length > limit
    echohl WarningMsg
    echo 'WARNING: Selection has length ' . length . ' but limit is ' . limit
    echohl None
    return
  endif

  if !empty($TMUX)
    let osc52_key = 'tmux'
  elseif match($TERM, 'screen') > -1
    let osc52_key = 'tmux'
  elseif match($TERM, 'tmux') > -1
    let osc52_key = 'tmux'
  elseif match($TERM, 'kitty') > -1
    let osc52_key = 'kitty'
  endif

  let osc52 = get(s:osc52_table, osc52_key, s:osc52_table['default'])(a:str)
  call s:raw_echo(osc52)
  echo 'Copied ' . length . ' bytes'
endfunction

" Send the visual selection to the terminal's clipboard using OSC52.
" https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! VisualOSC52Yank() range
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  call YankOSC52(join(lines, "\n"))
endfunction

function! s:get_OSC52(str)
  let b64 = s:b64encode(a:str, 0)
  return "\e]52;c;" . b64 . "\x07"
endfunction

function! s:get_OSC52_tmux(str)
  let b64 = s:b64encode(a:str, 0)
  return "\ePtmux;\e\e]52;c;" . b64 . "\x07\e\\"
endfunction

function! s:get_OSC52_kitty(str)
  call s:raw_echo("\e]52;c;!\x07")
  return s:get_OSC52(a:str)
endfunction

" Echo a string to the terminal without munging the escape sequences.
function! s:raw_echo(str)
  if has('win32') && has('nvim')
    call chansend(v:stderr, a:str)
  else
    if filewritable('/dev/fd/2')
      call writefile([a:str], '/dev/fd/2', 'b')
    else
      exec("silent! !echo " . shellescape(a:str))
      redraw!
    endif
  endif
endfunction

" Encode a string of bytes in base 64.
" If size is > 0 the output will be line wrapped every `size` chars.
function! s:b64encode(str, size)
  let bytes = s:str2bytes(a:str)
  let b64_arr = []

  for i in range(0, len(bytes) - 1, 3)
    let n = bytes[i] * 0x10000
          \ + get(bytes, i + 1, 0) * 0x100
          \ + get(bytes, i + 2, 0)
    call add(b64_arr, s:b64_table[n / 0x40000])
    call add(b64_arr, s:b64_table[n / 0x1000 % 0x40])
    call add(b64_arr, s:b64_table[n / 0x40 % 0x40])
    call add(b64_arr, s:b64_table[n % 0x40])
  endfor

  if len(bytes) % 3 == 1
    let b64_arr[-1] = '='
    let b64_arr[-2] = '='
  endif

  if len(bytes) % 3 == 2
    let b64_arr[-1] = '='
  endif

  let b64 = join(b64_arr, '')
  if a:size <= 0
    return b64
  endif

  let chunked = ''
  while strlen(b64) > 0
    let chunked .= strpart(b64, 0, a:size) . "\n"
    let b64 = strpart(b64, a:size)
  endwhile

  return chunked
endfunction

function! s:str2bytes(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

let s:osc52_table = {
      \ 'default': function('s:get_OSC52'),
      \ 'kitty': function('s:get_OSC52_kitty'),
      \ 'tmux': function('s:get_OSC52_tmux'),
      \ }

let s:b64_table = [
      \ "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
      \ "Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f",
      \ "g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v",
      \ "w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/",
      \ ]

command! -range OSCYank <line1>,<line2>call VisualOSC52Yank()
