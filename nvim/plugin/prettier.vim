" let g:prettier#autoformat_require_pragma = 1
let g:prettier#exec_cmd_async = 1
nmap <leader>fp <Plug>(Prettier)

" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

" autocmd BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync