let g:ale_lint_delay = 400
let g:ale_sign_column_always = 0

" Set this in your vimrc file to disabling highlighting
" let g:ale_set_highlights = 0

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" Set this. Airline will handle the rest.
" let g:airline#extensions#ale#enabled = 1
"
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

" Write this in your vimrc file
" let g:ale_set_loclist = 1
" let g:ale_set_quickfix = 1

" let g:ale_open_list = 1
" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
" let g:ale_keep_list_window_open = 1

" In ~/.vim/ftplugin/jsx.vim, or somewhere similar.
let b:ale_linter_aliases = ['css', 'javascript']
let b:ale_linters = ['stylelint', 'eslint']

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 10

" call neomake#configure#automake('rw', 1000)

" let g:neomake_open_list = 2

" let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
" let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" let g:neomake_javascript_enabled_makers = ['eslint']

