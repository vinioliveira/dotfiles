let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
      \ 'auto_complete_delay': 200,
      \ 'smart_case': v:true,
      \ })

set completeopt-=preview
