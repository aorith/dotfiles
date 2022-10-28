local packer_bootstrap, packer = require("plugins.plugins-setup")
if not packer_bootstrap then
  require("core")
  require("utils")
  require("plugins.config")
end
