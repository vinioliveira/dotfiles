require("settings.set")
require("settings.keymap")
require("settings.commands")
require("lazy.setup")

-- " For dark version.
-- set background=dark

-- " For light version.
-- set background=light

-- " Set contrast.
-- " This configuration option should be placed before `colorscheme gruvbox-material`.
-- " Available values: 'hard', 'medium'(default), 'soft'
-- let g:gruvbox_material_background = 'soft'

-- " For better performance
-- let g:gruvbox_material_better_performance = 1

--   colorscheme gruvbox-material


vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_better_performance = 1
vim.cmd.colorscheme 'gruvbox-material'
