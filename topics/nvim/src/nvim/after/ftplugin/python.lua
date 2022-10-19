-- Format code selection lines and pressing gq
-- Format entire buffer with gggqG 

-- LSP
vim.lsp.start({
   name = 'pylsp',
   cmd = {'pylsp'},
   root_dir = vim.fs.dirname(vim.fs.find({'.git', 'setup.py', 'pyproject.toml'}, { upward = true })[1]),
})

local virtual_env_dir = vim.fn.getenv('HOME') .. '/.local/venvs/nvim'
if vim.fn.empty(vim.fn.glob(virtual_env_dir)) > 0 then
    print "nvim virtual-env not present, create it with 'py-env nvim' and install pynvim, black, etc."
else
    vim.g["python3_host_prog"] = virtual_env_dir .. '/bin/python3'
    vim.cmd [[
        if !exists("g:my_black_function_loaded")
        function s:Black()
            if &filetype == "python"
            if &mod == 0
                execute ":!black " . resolve(expand('%:p'))
            else
                echohl ErrorMsg
                echomsg "Sorry, buffer has been modified. Save it first."
                echohl None
            endif
            else
            echohl ErrorMsg
            echomsg "Aborting, filetype is not python"
            echohl None
            endif
        endfunction

        function s:BlackDiff()
            if &filetype == "python"
            if &mod == 0
                " the character '#' is replaced by the filename
                :vnew | setlocal ft=diff buftype=nofile bufhidden=hide colorcolumn=0 noswapfile | r !black --quiet --diff #
            else
                echohl ErrorMsg
                echomsg "Sorry, buffer has been modified. Save it first."
                echohl None
            endif
            else
            echohl ErrorMsg
            echomsg "Aborting, filetype is not python"
            echohl None
            endif
        endfunction

        let g:my_black_function_loaded = 1
        endif
        command! Black call s:Black()
        command! BlackDiff call s:BlackDiff()
    ]]
end
