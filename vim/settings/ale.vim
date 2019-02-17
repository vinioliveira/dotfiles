let g:ale_lint_delay = 200
let g:ale_sign_column_always = 0

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 10

" let s:tslint_path = system('PATH=$(npm bin):$PATH && which tslint')
" let g:ale_typescript_tslint_executable= substitute(s:tslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" let g:ale_typescript_tslint_executable= substitute(s:tslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" let g:ale_typescript_tslint_config_path= getcwd().'/tslint.json'
"
" let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
" let g:ale_typescript_eslint_executable= substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" let g:ale_typescript_tslint_rules_dir = ["tslint-plugin-prettier"]
"
let g:ale_linter_aliases =
\ { 'typescriptreact': 'typescript',
\   'css': 'javascript' }

let g:ale_linters_ignore = {'typescript': ['eslint']}
