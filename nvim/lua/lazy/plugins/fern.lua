return {
  "lambdalisue/fern.vim",
  -- update mapping
  config = function()
    --" Use g? to show help instead of ?
    -- function! s:init_fern() abort
    --   nnoremap <buffer> <C-h> <C-w>h
    --   nnoremap <buffer> <C-l> <C-w>l
    -- endfunction
    -- translate to lua
    -- vim.cmd [[
    --   augroup fern
    --     autocmd!
    --     autocmd FileType fern lua
    -- " nmap <buffer> g? <Plug>(fern-action-help)
    --       vim.api.nvim_set_keymap('n', '<buffer>', 'g?', '<Plug>(fern-action-help)', { noremap = true })
    --   augroup END
    -- ]]
    --

    vim.api.nvim_set_keymap('n', '<leader>e', ':Fern %:p:h<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>d', ':Fern . -drawer -reveal<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>E', ':Fern . -drawer -reveal -toggle<CR>', { noremap = true, silent = true })

    vim.cmd [[
     function! s:init_fern() abort
        nnoremap <buffer> h <Plug>(fern-action-leave)
        nnoremap <buffer> o <Plug>(fern-action-open-or-expand)
        nnoremap <buffer> <Space> <Plug>(fern-action-mark)

     endfunction

     augroup fern-custom
      autocmd! *
      autocmd FileType fern call s:init_fern()
     augroup END
     ]]
  end

}
