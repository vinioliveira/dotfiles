let g:ale_lint_delay = 200
let g:ale_sign_column_always = 0
let g:ale_change_sign_column_color= 1

let g:ale_sign_error = "\uf057"
let g:ale_sign_warning = "\uf071"

nmap <silent> <leader>ap <Plug>(ale_previous_wrap)
nmap <silent> <leader>an <Plug>(ale_next_wrap)
nmap <silent> <leader>ai :ALEInfo<CR>
nmap <silent> <leader>a? :lopen<CR>

let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1

let g:ale_fix_on_save = 1



" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 10

" let s:tslint_path = system('PATH=$(npm bin):$PATH && which tslint')
" let g:ale_typescript_tslint_executable= substitute(s:tslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" let g:ale_typescript_tslint_executable= substitute(s:tslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" let g:ale_typescript_tslint_config_path= getcwd().'/tslint.json'

" let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
" let g:ale_typescript_eslint_executable= substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" let g:ale_typescript_tslint_rules_dir = ["tslint-plugin-prettier"]


let g:ale_linter_aliases = {
      \ 'typescriptreact': 'typescript',
      \ 'css': 'javascript' }

let g:ale_fixers = {
      \ 'javascript': ['prettier', 'trim_whitespace'],
      \ 'typescript': ['prettier', 'trim_whitespace'],
      \ 'ruby': ['rubocop']}

let g:ale_linters = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'typescript': ['tslint', 'tsserver', 'typecheck'],
      \ 'ruby': ['rubocop', 'ruby']}


