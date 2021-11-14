augroup VimWikiReloadHtml
  autocmd!
  autocmd BufWritePost * silent! :!touch ~/Syncthing/SYNC_STUFF/Wiki/.reload
augroup end

nnoremap <leader>nl :call myvimwiki#FZFLink()<CR>
