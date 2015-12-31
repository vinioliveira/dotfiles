require 'rake'
require 'fileutils'

task :install => [:submodules] do
  puts
  puts "======================================================"
  puts "Start dotfiles setup"
  puts "======================================================"
  puts

  install_homebrew if RUBY_PLATFORM.downcase.include?("darwin")
  install_files(Dir.glob('git/*'))
  install_files(Dir.glob('irb/*'))
  install_files(Dir.glob('ruby/*'))
  install_files(Dir.glob('ctags/*'))
  install_files(Dir.glob('tmux/*'))
  install_files(Dir.glob('{vimrc,gvimrc}'))
  Rake::Task["install_vundle"].execute
  Rake::Task["install_prezto"].execute
end

task :install_vundle do
  vundle_install
end

task :install_prezto do
  install_prezto
end

task :submodules do
  puts "======================================================"
  puts "Init Dotfile Submodules"
  puts "======================================================"

  run %{
      cd $HOME/.dotfiles
      git submodule update --init --recursive
      git clean -df
  }
  puts
end

task :default => 'install'

private
# to see more check https://github.com/skwp/dotfiles/blob/master/Rakefile
def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def install_homebrew
  run %{which brew}
  unless $?.success?
    puts "======================================================"
    puts "Installing Homebrew, the OSX package manager...If it's"
    puts "already installed, this will do nothing."
    puts "======================================================"
    run %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
  end

  puts
  puts
  puts "======================================================"
  puts "Updating Homebrew."
  puts "======================================================"
  run %{brew update}
  puts
  puts
  puts "======================================================"
  puts "Installing Homebrew packages...There may be some warnings."
  puts "======================================================"
  run %{brew install zsh ctags git hub tmux reattach-to-user-namespace the_silver_searcher}
  run %{brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit}
  puts
  puts
end

def install_prezto
  puts
  puts "Installing Prezto (ZSH Enhancements)..."

  run %{ ln -nfs "$HOME/.dotfiles/zsh/prezto" "${ZDOTDIR:-$HOME}/.zprezto" }

  # The prezto runcoms are only going to be installed if zprezto has never been installed
  install_files(Dir.glob('zsh/prezto/runcoms/z*'))

  puts
  puts "Overriding prezto ~/.zpreztorc with Dotfile's zpreztorc"
  run %{ ln -nfs "$HOME/.dotfiles/zsh/zpreztorc" "${ZDOTDIR:-$HOME}/.zpreztorc" }

  puts
  puts "Creating directories for your customizations"
  run %{ mkdir -p $HOME/.zsh.before }
  run %{ mkdir -p $HOME/.zsh.after }
  run %{ mkdir -p $HOME/.zsh.prompts }

  if ENV["SHELL"].include? 'zsh' then
    puts "Zsh is already configured as your shell of choice. Restart your session to load the new settings"
  else
    puts "Setting zsh as your default shell"
    if File.exists?("/usr/local/bin/zsh")
      if File.readlines("/private/etc/shells").grep("/usr/local/bin/zsh").empty?
        puts "Adding zsh to standard shell list"
        run %{ echo "/usr/local/bin/zsh" | sudo tee -a /private/etc/shells }
      end
      run %{ chsh -s /usr/local/bin/zsh }
    else
      run %{ chsh -s /bin/zsh }
    end
  end
end

def install_files(files)
  files.each do |f|
    file = f.split('/').last
    source = "#{ENV["PWD"]}/#{f}"
    target = "#{ENV["HOME"]}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exists?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %{ mv "$HOME/.#{file}" "$HOME/.#{file}.backup" }
    end

    run %{ ln -nfs "#{source}" "#{target}" }

    puts "=========================================================="
    puts
  end
end

def vundle_install
  system "vim --noplugin -N \"+set hidden\" \"+syntax on\" +BundleClean +BundleInstall! +qall"
end
