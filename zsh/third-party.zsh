# # Init the fasd
eval "$(fasd --init auto hub alias -s)"

autoload bashcompinit
bashcompinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. $(brew --prefix asdf)/asdf.sh
. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

source <(kubectl completion zsh)
