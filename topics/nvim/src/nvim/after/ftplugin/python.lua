-- Format code selection lines and pressing gq
-- Format entire buffer with gggqG

local virtual_env_dir = vim.fn.getenv('HOME') .. '/.local/venvs/nvim'
if vim.fn.empty(vim.fn.glob(virtual_env_dir)) > 0 then
    print "nvim virtual-env not present, create it with 'py-env nvim' and install pynvim, black, etc."
else
    vim.g["python3_host_prog"] = virtual_env_dir .. '/bin/python3'
end
