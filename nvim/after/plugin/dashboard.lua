local dashboard = require('dashboard')

dashboard.setup({
  theme = 'hyper',
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      {
        icon = '󱧘 ',
        desc = 'Install Plugins',
        group = 'Plugger',
        action = 'PlugInstall',
        key = 'i',
      },
      {
        icon = ' ',
        icon_hl = '@variable',
        desc = 'Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'p',
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
      {
        desc = ' Git Status',
        group = 'Number',
        action = 'Git',
        key = 'g',
      },
      {
        icon = ' ',
        desc = 'Quit',
        action = 'q!',
        key = 'q',
      },
    },
  },
})
