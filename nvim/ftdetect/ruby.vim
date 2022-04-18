autocmd BufRead,BufNewFile *.ru setfiletype ruby
autocmd BufRead,BufNewFile Gemfile setfiletype ruby

autocmd BufNewFile,BufRead *_spec.rb set syntax=rspec filetype=rspec.ruby
