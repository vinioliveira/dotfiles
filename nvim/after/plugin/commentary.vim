" mapping ctrl / ctrl / to comment out
map <c-c><c-c>  gcc
imap <c-c><c-c> <esc>gcc
vmap <c-c><c-c> gc

if exists('g:context#commentstring#table')
  let g:context#commentstring#table['react'] = {
              \ 'jsComment' : '// %s',
              \ 'jsImport' : '// %s',
              \ 'jsxStatment' : '// %s',
              \ 'jsxRegion' : '{/*%s*/}',
              \}
endif

