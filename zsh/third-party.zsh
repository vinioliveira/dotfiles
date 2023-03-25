eval "$(/opt/homebrew/bin/brew shellenv)"

# # Init the fasd
# eval "$(fasd --init auto hub alias -s)"

eval "$(zoxide init zsh)"

autoload bashcompinit
bashcompinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# . /opt/homebrew/opt/asdf/libexec/asdf.sh
. $(brew --prefix asdf)/libexec/asdf.sh
. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash


[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

source <(kubectl completion zsh)
source <(npm completion)


