#rbenv start
eval "$(rbenv init -)"

#nvm start
source $(brew --prefix nvm)/nvm.sh

# Init the fasd
eval "$(fasd --init auto hub alias -s)"


