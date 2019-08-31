let g:nvim_typescript#diagnostics_enable = 0
let g:nvim_typescript#max_completion_detail=50
let g:nvim_typescript#completion_mark=''
let g:nvim_typescript#javascript_support=1
let g:nvim_typescript#expand_snippet=0

autocmd BufWrite *.ts,*.tsx TSGetDiagnostic
