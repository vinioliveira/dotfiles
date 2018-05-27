""=============== VimFiler =====================
let g:vimfiler_as_default_explorer= 1
let g:vimfiler_define_wrapper_commands= 1
let g:vimfiler_safe_mode_by_default=0
let g:webdevicons_enable_vimfiler = 1
let g:vimfiler_tree_leaf_icon = " "
let g:vimfiler_tree_opened_icon = ''
let g:vimfiler_tree_closed_icon = ''
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '✓'
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_time_format = '%m-%d-%y %H:%M:%S'
let g:vimfiler_expand_jump_to_first_child = 0
let g:vimfiler_ignore_pattern =
      \ '^\%(\.git\|\.idea\|\.DS_Store\|\.vagrant\|.stversions'
      \ .'\|node_modules\|.*\.pyc\)$'


"====================  Maps =================================
map <leader>d <esc>:VimFiler <C-R>=getcwd()<CR><esc>
imap <leader>d <esc>:VimFiler <C-R>=getcwd()<CR><esc>

"Open in the current directory
map <Leader>e :VimFiler <C-R>=escape(expand("%:p:h")," ")<CR><esc>
imap <Leader>e :VimFiler <C-R>=escape(expand("%:p:h"),' ')<CR><esc>

"Open
map <leader>E <esc>:VimFilerExplorer <C-R>=getcwd()<CR><esc>
imap <leader>E <esc>:VimFilerExplorer <C-R>=getcwd()<CR><esc>
