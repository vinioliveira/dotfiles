# Path to your oh-my-zsh installation.
export TERM="xterm-256color"
export ZSH=$HOME/.oh-my-zsh

setopt RM_STAR_WAIT
setopt CORRECT

export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

#ZSH_THEME="vinioliveira"
ZSH_THEME="amuse-vinicius"

plugins=(git autojump z fasd)

source $ZSH/oh-my-zsh.sh

source $HOME/.dotfiles/scripts/export.sh
source $HOME/.dotfiles/scripts/other.sh
source $HOME/.dotfiles/scripts/alias.sh
source $HOME/.dotfiles/scripts/utils.sh

# Init the fasd
eval "$(fasd --init auto hub alias -s)"
