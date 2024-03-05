local dashboard = require('dashboard')

dashboard.setup({
  theme = 'hyper',
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      {
        icon = '󰊳 ',
        desc = 'Update Plugins',
        group = '@property',
        action = 'PlugUpdate',
        key = 'u',
      },
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' Apps',
        group = 'DiagnosticHint',
        action = "Defx -new `expand('%:p:h')` -search=`expand('%:p')<CR><esc>",
        key = 'a',
      },
      {
        desc = ' dotfiles',
        group = 'Number',
        action = 'Telescope dotfiles',
        key = 'd',
      },
    },
  },
})
