" :h new-filetype

if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.j2,*.jinja,*.jinja2 setfiletype htmldjango
augroup END
