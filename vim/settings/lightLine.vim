set laststatus=2

let g:lightline = {}
let g:lightline.colorscheme = 'solarized'
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.component_function = {
      \  'filename': 'LightLineFilename',
      \  'fugitive': 'LightLineFugitive',
      \ }
let g:lightline.component = {
      \  'readonly': '%{&readonly?"":""}',
      \ }
let g:lightline.component_expand = {
      \  'linter_checking': 'LintChecking',
      \  'linter_warnings': 'LintWarning',
      \  'linter_errors': 'LintError',
      \  'linter_ok': 'LintOk',
      \ }
let g:lightline.component_type = {
      \  'linter_checking': 'info',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \  'linter_ok': 'left',
      \ }

let g:lightline.active = {
      \  'left': [ [ 'mode', 'paste' ], [ 'fugitive'], ['filename' ] ],
      \  'right': [
      \     [ 'lineinfo' ],
      \     [ 'percent' ],
      \     [ 'fileformat', 'fileencoding', 'filetype' ],
      \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]
      \  ]
      \ }

"  ----   Functions
function! LightLineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? branch.' ' : ''
  endif
  return ''
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ '' != expand('%:t') ? @% : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LintChecking() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  return empty(info) ?  "\uf110 " : ''
endfunction

function! LintError() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'error', 0) ? printf("\uf057 " . '%d', info['error']) : ''
endfunction

function! LintWarning() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'warning', 0) ? printf("\uf071 " . '%d', info['warning']) : ''
endfunction

function! LintOk() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if !empty(info) && !get(info, 'warning', 0) && !get(info, 'error', 0)
    return "\uf00c "
  else
    return ''
  endif
endfunction

autocmd User CocDiagnosticChange call lightline#update()
