vim.loader.enable()
_G.map = vim.keymap.set
_G.notes_dir = vim.fn.expand("~/Syncthing/SYNC_STUFF/notes/main")

require("aorith.core.options")
require("aorith.core.autocmds")
require("aorith.core.keymaps")
require("aorith.core.notes")

require("aorith.core.lazy")
