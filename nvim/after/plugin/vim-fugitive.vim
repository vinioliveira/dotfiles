"============== Maps  ===========================
nnoremap <silent> gs :Git<CR>
nnoremap <silent> go :GBrowse<CR>
vnoremap <silent> go :GBrowse<CR>
nnoremap <silent> gd :Gvdiff<CR>
nnoremap <silent> gu :Dispatch git up<CR>
nnoremap <silent> gp ::echom('Pushing... ') \| Git push<CR>
nnoremap <silent> <leader>gf :echom('Force pushing... ') \| Git push --force-with-lease<CR>
nnoremap <silent> gb :Git blame<CR>
