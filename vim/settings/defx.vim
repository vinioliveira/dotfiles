""=============== VimFiler =====================
call defx#custom#column('time', { 'format': '%m-%d-%y %H:%M:%S' })

call defx#custom#column('mark', {
      \ 'directory_icon': '▸',
      \ 'readonly_icon': '✗',
      \ 'selected_icon': '✓',
      \ })

"====================  Maps =================================
map <leader>d <esc>:Defx <C-R>=getcwd()<CR><esc>
imap <leader>d <esc>:Defx <C-R>=getcwd()<CR><esc>

"Open in the current directory
map <Leader>e :Defx `expand('%:p:h')` -search=`expand('%:p')<CR><esc>
imap <Leader>e Defx `expand('%:p:h')` -search=`expand('%:p')<CR><esc>

"Open
map <leader>E :Defx -split=vertical -winwidth=50 -direction=topleft<CR><esc>
imap <leader>E :Defx -split=vertical -winwidth=50 -direction=topleft<CR><esc>

call defx#custom#option('_', {
    \ 'columns' :  'icons:indent:filename:type',
    \ 'buffer_name': 'defxplorer',
    \ 'listed': 1,
    \ 'toggle': 0,
    \ 'resume': 1
    \ })


autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
        \ defx#is_directory() ?
        \ defx#do_action('open_or_close_tree','recursive:10') :
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> o
        \ defx#is_directory() ?
        \ defx#do_action('open_or_close_tree') :
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
        \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
        \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> K
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
        \ defx#do_action('toggle_columns',
        \                'mark:filename:type:time')
  nnoremap <silent><buffer><expr> S
        \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
        \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
        \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
        \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
        \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
        \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
endfunction
