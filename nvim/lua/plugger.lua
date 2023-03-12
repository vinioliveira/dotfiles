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
Plug 'folke/tokyonight.nvim'

-- Syntax checking + Languages & Framework
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- tests
Plug('janko-m/vim-test', { ['on'] = { 'TestFile', 'TestNearest' } })

-- This plug-in provides automatic closing of quotes
Plug 'jiangmiao/auto-pairs'

-- For identation
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'lukas-reineke/indent-blankline.nvim'

-- Navigation
Plug('junegunn/fzf', { ['do'] = vim.fn['fzf#install'] })
Plug 'junegunn/fzf.vim'
Plug('Shougo/defx.nvim', { ['do'] = ':UpdateRemotePlugins' })
Plug 'chrisbra/nrrwrgn'
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'

-- LSP NVim options
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'ray-x/lsp_signature.nvim'
-- Plug 'onsails/lspkind-nvim'
--
Plug('glepnir/lspsaga.nvim', { ["branch"] = 'main' })
Plug 'jose-elias-alvarez/null-ls.nvim'

--Utils
Plug 'j-hui/fidget.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'

-- Others
Plug('MattesGroeger/vim-bookmarks', { ['on'] = { '<Plug>BookmarkToggle', '<Plug>BookmarkShowAll' } })
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'hoob3rt/lualine.nvim'
Plug 'tpope/vim-dispatch'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-scripts/IndexedSearch'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'github/copilot.vim'

-- Debug
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug "mxsdev/nvim-dap-vscode-js"

vim.call('plug#end')
