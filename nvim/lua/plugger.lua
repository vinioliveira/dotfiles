
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
Plug 'gruvbox-community/gruvbox'
Plug 'sjl/badwolf'
Plug 'chriskempson/base16-vim'
Plug 'arcticicestudio/nord-vim'

-- Plug 'jacoborus/tender.vim'
-- Plug 'mike-hearn/base16-vim-lightline'
-- Plug 'romainl/Apprentice'
-- Plug 'colepeters/spacemacs-theme.vim'
-- Plug 'ayu-theme/ayu-vim'
-- Plug 'joshdick/onedark.vim'
-- Plug 'overcache/NeoSolarized'
-- Plug 'sainnhe/gruvbox-material'

-- Syntax checking + Languages & Framework
Plug ('nvim-treesitter/nvim-treesitter', {['do']= ':TSUpdate'})

-- tests
Plug 'janko-m/vim-test'

-- This plug-in provides automatic closing of quotes
Plug 'jiangmiao/auto-pairs'

-- For identation
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'lukas-reineke/indent-blankline.nvim'

-- Navigation
Plug ('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })
Plug 'junegunn/fzf.vim'
Plug ('Shougo/defx.nvim', { ['do'] = ':UpdateRemotePlugins' })
Plug 'chrisbra/nrrwrgn'
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'

-- LSP NVim options
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/nvim-cmp'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind-nvim'

-- Others
Plug 'MattesGroeger/vim-bookmarks'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-dispatch'
Plug 'kevinhwang91/nvim-bqf'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-scripts/IndexedSearch'

-- if need re-enable it
-- Plug 'will133/vim-dirdiff'
-- Plug 'godlygeek/tabular'
vim.call('plug#end')