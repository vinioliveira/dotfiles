#rbenv start
eval "$(rbenv init -)"

#nvm start
# source $(brew --prefix nvm)/nvm.sh

# Init the fasd
eval "$(fasd --init auto hub alias -s)"


autoload bashcompinit
bashcompinit

eval "$(_TMUXP_COMPLETE=source tmuxp)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
