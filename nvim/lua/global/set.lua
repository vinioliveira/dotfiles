vim.g.wildignore = '*.o,*~,*.pyc'
vim.g.wildignore = '*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store'

vim.g.mapleader = ","

vim.opt.termguicolors = true
vim.opt.clipboard = "unnamed"

vim.api.nvim_command("set complete-=i") -- disable scanning included files
vim.api.nvim_command("set complete-=t") --disable searching tags
vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.mouse = "a"

vim.api.nvim_command("set title")
vim.api.nvim_command("set inccommand=split")
vim.apiesynmaxcol = "200"
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.backspace = [[indent,eol,start]]
vim.opt.list = true
vim.opt.listchars = [[tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»]]
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true


vim.opt.foldmethod   = "indent"
-- vim.opt.foldmethod   = "expr"
-- vim.opt.foldexpr     = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel    = 99

vim.o.foldnestmax    = 10 --         " deepest fold is 10 levels
--vim.g.formatoptions = '+=r'
vim.opt.smartindent  = true
vim.opt.conceallevel = 0
vim.opt.foldenable   = false -- don't fold by default


vim.opt.scrolloff            = 8
vim.opt.signcolumn           = "yes"

-- vim.api.nvim_command("filetype plugin indent on")

-- Always display sign column
vim.o.signcolumn             = "yes"

-- vim.opt.lazyredraw = true -- don't redraw while executing macros
-- vim.opt.laststatus = 2 -- the satus line all the time
-- vim.opt.so = 10 -- 7 lines to the cursors - when moving vertical
vim.opt.wildmenu             = true -- command line completion
vim.opt.hidden               = true -- buffer can be put into background
vim.opt.showcmd              = true -- incomplete commands
vim.opt.cursorline           = true

vim.opt.ignorecase           = true -- case insensitive searching
vim.opt.smartcase            = true -- case-sensitive if expresson contains a capital letter
vim.opt.hlsearch             = true -- highlight search results
vim.opt.showmatch            = true -- show matching braces
vim.opt.mat                  = 2    -- how many tenths of a second to blink

vim.opt.swapfile             = false
vim.opt.backup               = false
vim.opt.wb                   = false

vim.g.loaded_gzip            = 1
vim.g.loaded_zip             = 1
vim.g.loaded_zipPlugin       = 1
vim.g.loaded_tar             = 1
vim.g.loaded_tarPlugin       = 1

vim.g.loaded_getscript       = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball         = 1
vim.g.loaded_vimballPlugin   = 1
vim.g.loaded_2html_plugin    = 1

vim.g.loaded_matchit         = 1
vim.g.loaded_matchparen      = 1
vim.g.loaded_logiPat         = 1
vim.g.loaded_rrhelper        = 1

-- vim.opt.termguicolors=true
vim.opt.wildoptions          = 'pum'

-- Disable default netrw
-- vim.g.loaded_netrw = 0
-- vim.g.loaded_netrwPlugin = 0
