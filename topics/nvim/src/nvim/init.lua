-- install packer & initial setup
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1f2229" })
    print("Cloning packer ..")
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    require("aorith.plugins.plugins")

    vim.cmd("PackerSync")
    -- reload when PackerSync is done
    vim.api.nvim_create_autocmd("User", {
        pattern = "PackerComplete",
        callback = function()
            dofile(vim.env.MYVIMRC)
        end,
    })
else
    require("plugins")
    require("options")
    require("remaps")
end
