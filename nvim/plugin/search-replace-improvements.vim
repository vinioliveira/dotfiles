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
  execute ":Ag ".selection
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



" Mappings
vnoremap <leader>r :call Get_visual_selection()<cr>
vnoremap <leader>ag :call Get_visual_selection_rg()<cr>
vnoremap <leader>af :call Get_visual_selection_ag_folder()<cr>
nnoremap <Leader>R :cfdo %s//g \| update<C-Left><C-Left><Left><Left><Left>


