# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

setopt RM_STAR_WAIT
setopt CORRECT

export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

source $HOME/.dotfiles/scripts/export.sh
source $HOME/.dotfiles/scripts/other.sh
source $HOME/.dotfiles/scripts/alias.sh
source $HOME/.dotfiles/scripts/utils.sh

bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
