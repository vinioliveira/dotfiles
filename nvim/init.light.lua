require("settings.set")
require("settings.keymap")
require("settings.commands")
require("lazy.setup")


vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_better_performance = 1
vim.o.background = "light"

vim.cmd.colorscheme 'gruvbox-material'
