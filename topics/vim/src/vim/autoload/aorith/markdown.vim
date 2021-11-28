" Navigate MdLinks
function aorith#markdown#navigateLink()
  if getline('.') !~? '.*\[.\+\]\(.\+\).*'
    return
  endif
  let l:target_link = substitute(getline('.'), '.*(\(.\+\)).*', '\1', '')
  let g:netrw_browsex_viewer = '-'
  execute ':normal 0f(l'
  if l:target_link =~? '.\+\.\(png\|jpg\|jpeg\|svg\|gif\|webp\|bmp\|pdf\)'
    execute ':normal gx'
  else
    execute ':normal gf'
  endif
endfunction
