let g:bookmark_no_default_key_mappings = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_close = 0  "Automatically close bookmarks split when jumping to a bookmark
let g:bookmark_display_annotation = 1

nmap mm <Plug>BookmarkToggle
nmap mi <Plug>BookmarkAnnotate
nmap ma <Plug>BookmarkShowAll
nmap mn <Plug>BookmarkNext
nmap mp <Plug>BookmarkPrev
nmap mc <Plug>BookmarkClear
nmap mx <Plug>BookmarkClearAll
