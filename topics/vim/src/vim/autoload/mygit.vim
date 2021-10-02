" Git functions

" Show in a terminal the commit that introduced current(selected) line
" If a count was given, show full history
" Usage: noremap <Leader>g :call git#show_commit(v:count)<CR>
function! mygit#show_commit(count) range
  let depth = (a:count > 0 ? "" : "-n 1")
  let git_cmd = "git -C " .. fnamemodify(resolve(expand('%:p')), ":h") ..
        \ " log --no-merges " .. depth .. " -L " ..
        \ a:firstline .. "," . a:lastline .. ":" .. resolve(expand("%:p"))
  execute ":term ++noclose " .. git_cmd
endfunction

" Src: https://github.com/habamax/.vim
" Show commit that introduced current(selected) line
" If a count was given, show full history
" Src: https://www.reddit.com/r/vim/comments/i50pce/how_to_show_commit_that_introduced_current_line/
" Usage: noremap <Leader>g :call git#show_commit(v:count)<CR>
function! mygit#show_commit_popup(count) range
  let depth = (a:count > 0 ? "" : "-n 1")
  let git_output = systemlist(
        \ "git -C " .. shellescape(fnamemodify(resolve(expand('%:p')), ":h")) ..
        \ " log --no-merges " .. depth .. " -L " ..
        \ shellescape(a:firstline .. "," . a:lastline .. ":" .. resolve(expand("%:p")))
        \ )

  let winnr = popup_atcursor(git_output, { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })
  call setbufvar(winbufnr(winnr), "&filetype", "git")
endfunction

" Blame current (selected) line.
" Usage: noremap <Leader>gb :call git#blame()<CR>
function! mygit#blame_popup() range
  let git_output = systemlist(
        \ "git -C " .. shellescape(fnamemodify(resolve(expand('%:p')), ":h")) ..
        \ " blame -L " ..
        \ a:firstline .. "," . a:lastline .. " " .. expand("%:t")
        \ )

  let winnr = popup_atcursor(git_output, { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })
  call setbufvar(winbufnr(winnr), "&filetype", "git")
endfunction
