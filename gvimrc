" Example Vim graphical configuration.
" Copy to ~/.gvimrc or ~/_gvimrc.
"
set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.
set lines=25 columns=100          " Window dimensions.
" Save using Command-S on MacVim without replacing
noremap <D-s> :w<CR>
colorscheme hybrid_material

set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12
