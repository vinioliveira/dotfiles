let g:bookmark_no_default_key_mappings = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_close = 1  "Automatically close bookmarks split when jumping to a bookmark
let g:bookmark_display_annotation = 1

nmap <leader>mm <Plug>BookmarkToggle
nmap <leader>mi <Plug>BookmarkAnnotate
nmap <leader>ma <Plug>BookmarkShowAll
nmap <leader>mn <Plug>BookmarkNext
nmap <leader>mp <Plug>BookmarkPrev
nmap <leader>mc <Plug>BookmarkClear
nmap <leader>mx <Plug>BookmarkClearAll
