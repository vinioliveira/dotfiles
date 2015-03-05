# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

#ZSH_THEME="vinioliveira"
ZSH_THEME="bira"

plugins=(git rbenv osx autojump)

source $ZSH/oh-my-zsh.sh

# Enables the edition of command lines!
# press cltr+x cltr+e to open the editor and fix any command line errors
autoload edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

source $HOME/.dotfiles/scripts/export.sh
source $HOME/.dotfiles/scripts/other.sh
source $HOME/.dotfiles/scripts/alias.sh
source $HOME/.dotfiles/scripts/utils.sh

# Init the fasd
eval "$(fasd --init auto)"


