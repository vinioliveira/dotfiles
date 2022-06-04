" https://github.com/vuciv/vim-bujo

nmap <leader>td :Todo<cr>
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal

let g:bujo#todo_file_path = $HOME . "/.cache/bujo"
let g:bujo#window_width = 40
