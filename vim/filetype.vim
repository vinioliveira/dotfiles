" Ruby
" -----------------------------------------------------------------
augroup rubyfiletype
  autocmd BufRead,BufNewFile *.ru setfiletype ruby
  autocmd BufRead,BufNewFile Gemfile setfiletype ruby
augroup END

" RSpec
" -----------------------------------------------------------------
augroup filetypedetect
  au! BufRead,BufNewFile *_spec.rb		set filetype=ruby.rspec
augroup END

" tmux
" -----------------------------------------------------------------
augroup tmuxfiletype
  autocmd BufRead,BufNewFile .tmux.conf setfiletype tmux
augroup END

" JavaScript
" -----------------------------------------------------------------
augroup javascriptfiletype
  autocmd BufRead,BufNewFile *.es6 set filetype=javascript.jsx
  autocmd BufRead,BufNewFile *.js.es6 set filetype=javascript.jsx
augroup END
