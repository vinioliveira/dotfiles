eval "$(/opt/homebrew/bin/brew shellenv)"

# # Init the fasd
# eval "$(fasd --init auto hub alias -s)"

eval "$(zoxide init zsh)"

autoload bashcompinit
bashcompinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

[[ $commands[npm] ]] && source <(npm completion)


