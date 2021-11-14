" Helper function to get the relative path using python 'os.path'
function myvimwiki#getRelativePath(curr_path, target_fp)
  " if 'curr_path' is '/home/user/Docs'
  " and 'target_fp' is '/home/user/Docs/test/file.txt'
  " returns 'test/file.txt'
  py3 import os.path, vim;
        \ curr_path = vim.eval('fnameescape(a:curr_path)');
        \ target_fp = vim.eval('fnameescape(a:target_fp)');
        \ vim.command('let l:rel_path="' + os.path.relpath(target_fp, curr_path) + '"');
  return l:rel_path
endfunction

" Create a link to selected file
function myvimwiki#fzfLinkHandler(file)
  call inputsave()
  let l:filename = split(a:file, '/')[-1]
  let l:name = input('Save resource (' . l:filename . ') as: ')
  call inputrestore()
  if empty(l:name)
    let l:name = l:filename
  endif
  if !empty(glob(g:myvimwiki_dir . '/resources/' . l:name))
    echohl ErrorMsg
    echomsg 'A file with the name "' . l:name . '" already exists.'
    echohl None
    return
  endif
  execute ':!cp ' . a:file . ' ' . g:myvimwiki_dir . '/resources/' . l:name

  let l:curr_path = expand('%:p:h')
  let l:target_fp = g:myvimwiki_dir . '/resources/' . l:name
  let l:rel_path = myvimwiki#getRelativePath(l:curr_path, l:target_fp)

  if a:file =~? '.\+\.\(png\|jpg\|jpeg\|svg\|gif\|webp\|bmp\)'
    let l:img_str = '!'
  else
    let l:img_str = ''
  endif
  " Insert the markdown link to the file in the current buffer
  let l:mdlink = l:img_str . '[file:'.l:name.']('.l:rel_path.')'
  put=l:mdlink
  execute ':cd ' . g:myvimwiki_oldpath
endfunction

function myvimwiki#FZFLink()
  let g:myvimwiki_oldpath = getcwd()
  command! -nargs=1 ZNotesFZFOutHandler :call myvimwiki#fzfLinkHandler(<f-args>)
  execute ':cd $HOME'
  call fzf#run(fzf#wrap({'dir': $HOME, 'sink': 'ZNotesFZFOutHandler', 'options': ['--preview=bat --style header,grid --color always {}']}))
  execute ':cd ' . g:myvimwiki_oldpath
endfunction
