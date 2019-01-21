#rbenv start
eval "$(rbenv init -)"

#nvm start
export NVM_DIR="/usr/local/var/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Init the fasd
eval "$(fasd --init auto hub alias -s)"


autoload bashcompinit
bashcompinit

eval "$(_TMUXP_COMPLETE=source tmuxp)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
