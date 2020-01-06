require 'rake'
require 'fileutils'

task :pre_install do
  puts
  puts '======================================================'
  puts '            Start dotfiles setup                      '
  puts '======================================================'
  puts
end

task submodules: [:pre_install] do
  puts '======================================================'
  puts '           Init Dotfile Submodules                    '
  puts ' ====================================================== '
  run %(
    cd $HOME/.dotfiles
    git submodule update --init --recursive
    git clean -df
  )
  puts
end

task install_homebrew: [:submodules] do
  install_homebrew
end

task install_others: [:install_homebrew] do
  install_others
end

task copy_files: [:install_others] do
  install_file(Dir.glob('git/*'))
  install_file(Dir.glob('irb/*'))
  install_file(Dir.glob('ruby/*'))
  install_file(Dir.glob('ctags/*'))
  install_file(Dir.glob('tmux/*'))
  install_files(Dir.glob('karabiner/*'), "#{ENV['HOME']}/.config")
  install_files(Dir.glob('vim/init.vim'), "#{ENV['HOME']}/.config")
  install_file(Dir.glob('vim/{vimrc,gvimrc}'))
end

task install_pip_depdencies: [:copy_files] do
  install_pip_depdencies
end

task config_tmux_powerline: [:install_pip_depdencies] do
  config_tmux_powerline
end

task install_vim_plugins: [:config_tmux_powerline] do
  install_vim_plugins
end

task install_prezto: [:install_vim_plugins]  do
  install_prezto
end

task install: :install_prezto

task default: 'install'

private
# to see more check https://github.com/skwp/dotfiles/blob/master/Rakefile
def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def install_homebrew
  run %(which brew)
  unless $?.success?
    puts '======================================================'
    puts "Installing Homebrew, the OSX package manager...If it's"
    puts 'already installed, this will do nothing.'
    puts '======================================================'
    run %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  end

  puts
  puts
  puts '======================================================'
  puts 'Updating Homebrew.'
  puts '======================================================'
  run %(brew update)
  puts
  puts
  puts '======================================================'
  puts 'Installing Homebrew packages...There may be some warnings.'
  puts '======================================================'
  run %( brew install ctags fasd fzf git ghostscript graphviz httpie hub ifstat imagemagick openssl python pgcli readline redis reattach-to-user-namespace sqlite the_silver_searcher tmux vim watch yarn zsh zsh-completions neovim ansible)
  puts
  puts
#   puts '======================================================'
#   puts 'Installing Homebrew packages that helps bluetooth issue'
#   puts '======================================================'
#   run %( brew install blueutil sleepwatcher )
  puts
  puts '======================================================'
  puts 'Installing Homebrew cask packages...There may be some warnings.'
  puts '======================================================'
  run %(brew cask install keepingyouawake 1password postman google-chrome fantastical studio-3t muzzle slack alfred dash iterm2 appcleaner teensy cloudapp google-backup-and-sync docker istat-menus karabiner-elements microsoft-teams rescuetime spotify the-unarchiver timemachineeditor vlc evernote oracle-jdk spectacle visual-studio-code rowanj-gitx dbeaver-community)
  puts
  puts

  puts '======================================================'
  puts 'Installing tap fonts cask packages...There may be some warnings.'
  puts '======================================================'
  run %(  brew tap homebrew/cask-fonts     )
  run %( brew cask install font-firacode-nerd-font )
  puts
end

def install_others
  puts '======================================================'
  puts 'Installing ASDF packages...There may be some warnings.'
  puts '======================================================'
  run %( brew install asdf coreutils automake autoconf libyaml libxslt libtool unixodbc unzip gpg )
  puts
  puts
  puts '======================================================'
  puts 'Installing Node Import the Node.js release teams OpenPGP keys to main keyring'
  puts '======================================================'
  run %( bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring)
  puts
  puts
  puts '======================================================'
  puts 'Installing asdf plugins'
  puts '======================================================'
  run %(asdf plugin-add ruby )
  run %(asdf plugin-add nodejs )
  puts
  puts
  puts '======================================================'
  puts 'Installing FZF.'
  puts '======================================================'
  run %($(brew --prefix)/opt/fzf/install)
  puts
  puts
end

def install_prezto
  puts
  puts 'Installing Prezto (ZSH Enhancements)...'

  run %( git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" )

  # The prezto runcoms are only going to be installed if zprezto has never been installed
  install_file(Dir.glob('zsh/prezto/runcoms/z*'))

  puts
  puts "Overriding prezto ~/.zpreztorc with Dotfile's zpreztorc"
  run %( ln -nfs "$HOME/.dotfiles/zsh/zpreztorc" "${ZDOTDIR:-$HOME}/.zpreztorc" )

  puts
  puts "Overriding prezto ~/.zshrc with Dotfile's zshrc"
  run %( ln -nfs "$HOME/.dotfiles/zsh" "$HOME/.zsh" )
  run %( ln -nfs "$HOME/.dotfiles/zsh/zshrc" "$HOME/.zshrc" )

  puts
  puts 'Creating directories for your customizations'
  run %( mkdir -p $HOME/.zsh.before )
  run %( mkdir -p $HOME/.zsh.after )
  run %( ln -nfs "$HOME/.dotfiles/zsh/prezto-themes/prompt_vini_setup" "$HOME/.zprezto/modules/prompt/functions" )

  puts
  puts 'Creating secrets exports'
  run %( touch $HOME/.dotfiles/zsh/secrets.zsh )
  run %( echo "export HOMEBREW_GITHUB_API_TOKEN=\"\"\nexport GITHUB_TOKEN=\"\"" >> $HOME/.dotfiles/zsh/secrets.zsh )

  puts
  puts 'Linking bluetooth restart scripts'
  run %( ln -nfs "$HOME/.dotfiles/scripts/restart-bluetooth.sh" "/usr/local/bin" )
  run %( chmod -x "/usr/local/bin/restart-bluetooth.sh" )

  if ENV['SHELL'].include? 'zsh'
    puts 'Zsh is already configured as your shell of choice. Restart your session to load the new settings'
  else
    puts 'Setting zsh as your default shell'
    if File.exist?('/usr/local/bin/zsh')
      if File.readlines('/private/etc/shells').grep('/usr/local/bin/zsh').empty?
        puts 'Adding zsh to standard shell list'
        run %( echo "/usr/local/bin/zsh" | sudo tee -a /private/etc/shells )
      end
      run %( chsh -s /usr/local/bin/zsh )
    else
      run %( chsh -s /bin/zsh )
    end
  end
end

def install_karabiner
  Dir.glob('karabiner/*').each do |f|
    file = f.split('/').last
    source = "#{ENV['PWD']}/#{f}"
    target = "#{ENV['HOME']}/.config/karabiner/#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exist?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %( mv "$HOME/.#{file}" "$HOME/.#{file}.backup" )
    end

    run %( ln -nfs "#{source}" "#{target}" )

    puts '=========================================================='
    puts
  end
end

def install_file(files)
  install_files(files, ENV['HOME'])
end

def install_files(files, destination)
  files.each do |f|
    file = f.split('/').last
    source = "#{ENV['PWD']}/#{f}"
    target = "#{destination}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exist?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %( mv "$HOME/.#{file}" "$HOME/.#{file}.backup" )
    end

    run %( ln -nfs "#{source}" "#{target}" )

    puts '=========================================================='
    puts
  end
end

def install_pip_depdencies
  puts '======================================================'
  puts 'Installing pip dependencies'
  puts '======================================================'
  run %(pip3 install tmuxp)
end

def config_tmux_powerline
  puts '======================================================'
  puts 'Customizing tmux-powerline'
  puts '======================================================'

  puts 'Linking custom theme'
  run %( ln -nfs "$HOME/.dotfiles/tmux/themes/powerline-theme.sh" "${ZDOTDIR:-$HOME}/.dotfiles/tmux/tmux-powerline/themes" )
end

def install_vim_plugins
  puts '======================================================'
  puts 'Installing vim plugings'
  puts '======================================================'
  system 'vim --noplugin -N "+set hidden" "+syntax on" +PlugClean +PlugInstall! +qall'

  puts 'linking custom snippets'
  run %( ln -nfs "$HOME/.dotfiles/vim/UltiSnips" "${ZDOTDIR:-$HOME}/.vim" )
end
