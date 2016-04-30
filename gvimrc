" Example Vim graphical configuration.
" Copy to ~/.gvimrc or ~/_gvimrc.
"
set guifont=Monaco:h12
set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.
set background=light              " Background.
set lines=25 columns=100          " Window dimensions.
" Save using Command-S on MacVim without replacing
noremap <D-s> :w<CR>
colorscheme hybrid_material
