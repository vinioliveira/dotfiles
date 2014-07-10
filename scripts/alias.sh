alias ll="ls -Glahs"
alias ls="ls -G"
alias make="make -j2"
alias mysql="mysql --auto-vertical-output"
alias ni="lsof -i -Pn"
alias psgrep="ps aux | egrep -v egrep | egrep"

alias r="rails"

alias redis="redis-server"
alias top="top -o cpu"
alias vim="vim -N"

alias xmldelete="curl -X DELETE -H 'Accept: application/xml'"
alias xmlget="curl -X GET -H 'Accept: application/xml'"
alias xmlpost="curl -X POST -H 'Accept: application/xml'"
alias xmlput="curl -X PUT -H 'Accept: application/xml'"

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

#Just give a try to Git alias thanks to Celso Dantas
alias glog="git log --graph --pretty='format:%C(yellow)%h%C(cyan)%d%Creset %s => %C(green)%an%C(white), %C(red)%ar%Creset'"
alias gca="git add --all && git commit -a"
alias gl="git log --graph --pretty='format:%C(yellow)%h%C(cyan)%d%Creset %s => %C(green)%an%C(white), %C(red)%ar%Creset'"
alias gs="git status"
alias g='git'
alias gd="git diff"
