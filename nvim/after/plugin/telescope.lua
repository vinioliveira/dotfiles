local actions = require('telescope.actions')

require('telescope').setup {

  defaults = {
    layout_strategy = "bottom_pane",
    layout_config = {
      bottom_pane = {
        height = .3,
        prompt_position = "bottom",
      },
      -- width = 0.75,
      -- height = 0.75,
      -- horizontal = {
      --   width = 0.75,
      --   height = 0.75,
      -- },
      -- vertical = {
      --   width = 0.75,
      --   height = 0.75,
      -- },
    },
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- ["<esc>"] = require('telescope.actions').close,
        ["<c-a>"] = actions.toggle_all,
        ["<C-u>"] = false,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
      }
    }
  },
  -- pickers = {
  --   find_files = {
  --     theme = "ivy",
  --   }
  -- },
}



local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<c-b>', builtin.buffers, {})
vim.keymap.set('n', '<leader>ag', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local function getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

vim.keymap.set('v', '<leader>*', function()
  local text = getVisualSelection()
  builtin.grep_string({ default_text = text })
end, {})


-- "let g:fzf_layout = { 'up': '~30%' }
-- "let g:fzf_history_dir = '~/.config/nvim/fzf-history'
-- "let $BAT_THEME="gruvbox-dark"

-- "" let g:fzf_preview_window = 'right:60%'

-- "" " In Neovim, you can set up fzf window using a Vim command
-- "" " let g:fzf_layout = { 'window': 'belowright 15sp enew' }

-- "let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all,ctrl-d:half-page-down,ctrl-u:half-page-up'

-- "" function! s:build_quickfix_list(lines)
-- ""   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
-- ""   copen
-- ""   cc
-- "" endfunction

-- "let g:fzf_action = {
-- "      \ 'ctrl-t': 'tab split',
-- "      \ 'ctrl-x': 'split',
-- "      \ 'ctrl-v': 'vsplit' }


-- "let g:fzf_preview_window = ['right:40%', 'ctrl-/']
-- "" [Buffers] Jump to the existing window if possible
-- "let g:fzf_buffers_jump = 1


-- "" command! -bang -nargs=* -complete=dir Ag
-- ""   \ call fzf#vim#grep('ag --nogroup --column --color '.join(map([<f-args>], 'shellescape(v:val)')), 0
-- ""   \   fzf#vim#with_preview(), <bang>0)
-- ""
-- "command! -bang -nargs=+ -complete=file Ag call fzf#vim#ag_raw(<q-args>, fzf#vim#with_preview(), <bang>0)


-- "" ============ MAPS ==============
-- "nnoremap <C-b> :Buffers<CR>
-- "nnoremap <C-p> :Files<CR>
-- "" nnoremap <C-f> :Ag<space>
-- "nnoremap <leader>ag :Ag<space>

-- "function! CloseAllBuffersButCurrent()
-- "  let curr = bufnr("%")
-- "  let last = bufnr("$")

-- "  if curr > 1    | silent! execute "1,".(curr-1)."bd"     | endif
-- "  if curr < last | silent! execute (curr+1).",".last."bd" | endif
-- "endfunction

-- "command! BufferDelete call CloseAllBuffersButCurrent()

-- "" nnoremap <leader>f :BTags<CR>
-- "" nnoremap <leader>F :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>

-- "" " Insert mode completion
-- "" " imap <c-x><c-k> <plug>(fzf-complete-word)
-- "" " imap <c-x><c-f> <plug>(fzf-complete-path)
-- "" " imap <c-x><c-j> <plug>(fzf-complete-file-ag)
-- "" " imap <c-x><c-l> <plug>(fzf-complete-line)
-- "" " inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

-- "function! s:list_buffers()
-- "  redir => list
-- "  silent ls
-- "  redir END
-- "  return split(list, "\n")
-- "endfunction

-- "function! s:delete_buffers(lines)
-- "  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
-- "endfunction

-- "command! BufferList call fzf#run(fzf#wrap({
-- "  \ 'source': s:list_buffers(),
-- "  \ 'sink*': { lines -> s:delete_buffers(lines) },
-- "  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
-- "\ }))
