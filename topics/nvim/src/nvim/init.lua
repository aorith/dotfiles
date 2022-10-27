local packer_bootstrap, packer = require("plugins.plugins-setup")
if not packer_bootstrap then
    require("options")
    require("remaps")
    require("plugins.config")
end
