augroup VimWikiReloadHtml
  autocmd!
  autocmd BufWritePost * silent! :!touch $MY_WIKI_DIR/.reload
augroup end

nnoremap <leader>nl :call myvimwiki#FZFLink()<CR>
