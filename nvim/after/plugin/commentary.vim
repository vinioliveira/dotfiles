" mapping ctrl / ctrl / to comment out
map <c-_><c-_> gcc
imap <c-_><c-_> <esc>gcc
vmap <c-_><c-_> gc

if exists('g:context#commentstring#table')
  let g:context#commentstring#table['react'] = {
              \ 'jsComment' : '// %s',
              \ 'jsImport' : '// %s',
              \ 'jsxStatment' : '// %s',
              \ 'jsxRegion' : '{/*%s*/}',
              \}
endif

