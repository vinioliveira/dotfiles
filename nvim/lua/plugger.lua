vim.cmd([[
if empty(glob($HOME."/.local/share/nvim/site/autoload"))

  " Ensure all needed directories exist  (Thanks @kapadiamush)
  " For Neovim: ~/.local/share/nvim/plugged
  echom "This will install vim plgin"
  silent execute '!mkdir -p ~/.local/share/nvim/plugged'
  silent execute '!mkdir -p ~/.local/share/nvim/site/autoload'
  echom "Download the actual plugin manager"
  silent execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
]])

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')

-- Themes
Plug 'rose-pine/neovim'
-- Plug 'folke/tokyonight.nvim'
-- Plug 'w0ng/vim-hybrid'
-- Plug 'sainnhe/everforest'
-- Plug 'RRethy/nvim-base16'
-- Plug 'catppuccin/nvim'
-- Plug "ellisonleao/gruvbox.nvim"
-- Plug 'sainnhe/gruvbox-material'
-- Plug('AlexvZyl/nordic.nvim', { ['branch'] = 'main' })
-- Plug 'nordtheme/vim'
-- Plug 'Verf/deepwhite.nvim'
-- Plug "rebelot/kanagawa.nvim"
-- Plug 'navarasu/onedark.nvim'


-- Syntax checking + Languages & Framework
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- tests
Plug('janko-m/vim-test', { ['on'] = { 'TestFile', 'TestNearest' } })

-- This plug-in provides automatic closing of quotes
Plug 'windwp/nvim-autopairs'

-- For identation
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'lukas-reineke/indent-blankline.nvim'

-- Navigation
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.5', frozen = true })
Plug('nvim-telescope/telescope-fzf-native.nvim',
  {
    ['do'] =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  })
Plug('Shougo/defx.nvim', { ['do'] = ':UpdateRemotePlugins' })
Plug 'chrisbra/nrrwrgn'
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'

-- LSP NVim options
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/cmp-cmdline'

--
Plug 'rmagatti/goto-preview'
Plug 'mfussenegger/nvim-lint'
Plug 'stevearc/conform.nvim'

--Utils
Plug('j-hui/fidget.nvim', { ['tag'] = 'legacy' })
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug('ThePrimeagen/harpoon', { ["branch"] = 'harpoon2' })
Plug 'nvim-treesitter/nvim-treesitter-context'
-- Plug 'nvimdev/dashboard-nvim'
Plug 'folke/todo-comments.nvim'
Plug 'mbbill/undotree'

-- Others
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'hoob3rt/lualine.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-scripts/IndexedSearch'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'github/copilot.vim'

vim.call('plug#end')
