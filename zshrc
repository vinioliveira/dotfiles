# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="vinioliveira"

plugins=(git fasd autojump)

source $ZSH/oh-my-zsh.sh

source $HOME/.dotfiles/scripts/export.sh
source $HOME/.dotfiles/scripts/other.sh
source $HOME/.dotfiles/scripts/alias.sh
source $HOME/.dotfiles/scripts/utils.sh

# Init the fasd
eval "$(fasd --init auto hub alias -s)"
