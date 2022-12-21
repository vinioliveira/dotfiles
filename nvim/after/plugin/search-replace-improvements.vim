function! Get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  let selection = join(lines,'\n')
  let change = input('Replace with: ')
  if change !=  ""
    execute ":%s/".selection."/".change."/g"
  endif
endfunction


function! Get_visual_selection_rg()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  let selection = join(lines,'\n')
  " let change = input('Replace with: ')
  execute ":Ag \"".selection."\""
endfunction


function! Get_visual_selection_ag_folder()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  let selection = join(lines,'\n')
  let folder = input('Folder: ', "", "file")
  if folder !=  ""
    execute ":Ag ".selection." ".folder
  endif
endfunction



" if selection mode : grab selection
" if normal mode: prompt command
" if normal mode differnt command: grap word


" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

vnoremap <leader>* :call Get_visual_selection_rg()<cr>
" Mappings
vnoremap <leader>r :call Get_visual_selection()<cr>
vnoremap <leader>af :call Get_visual_selection_ag_folder()<cr>
" nnoremap <leader>R :cfdo %s//g \| update<C-Left><C-Left><Left><Left><Left>

" Easier fold toggling
nnoremap <leader>z za
nnoremap <leader>S :%s//gc<Left><Left><Left>
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn
" Start substitute on current word under the cursor
" nnoremap <Leader>r :%s///g<Left><Left>
" nnoremap <Leader>rc :%s///gc<Left><Left>
nnoremap <Leader>R :cfdo %s//g \| update<C-Left><C-Left><Left><Left><Left><Left>
