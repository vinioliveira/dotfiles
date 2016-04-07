alias ll="ls -Glahs"
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

alias jsondel="curl -X DELETE -H 'Accept: application/json'"
alias jsonget="curl -X GET -H 'Accept: application/json'"
alias jsonpost="curl -X POST -H 'Accept: application/json'"
alias jsonput="curl -X PUT -H 'Accept: application/json'"

alias xmldelete="curl -X DELETE -H 'Accept: application/xml'"
alias xmlget="curl -X GET -H 'Accept: application/xml'"
alias xmlpost="curl -X POST -H 'Accept: application/xml'"
alias xmlput="curl -X PUT -H 'Accept: application/xml'"

#Adding hub alias to git
alias git="hub"

#Just give a try to Git alias thanks to Celso Dantas
alias g='git'
alias glog="git log --graph --pretty='format:%C(yellow)%h%C(cyan)%d%Creset %s => %C(green)%an%C(white), %C(red)%ar%Creset'"
alias gl="git log --graph --pretty='format:%C(yellow)%h%C(cyan)%d%Creset %s => %C(green)%an%C(white), %C(red)%ar%Creset'"
alias gs="git status"
alias gd="git diff"
alias go='git browse'
alias gop='git browse -- pulls'

alias t="tmux"
alias tn="tmux new -s"
alias tls="tmux ls"
alias tkill="tmux kill-session -t"

#Grunt alias
alias gt="grunt"
alias gts="grunt serve"
alias gtsa="grunt serve --allow-remote"
alias gtjh="grunt jshint"
alias gtt="grunt test"
alias gtb="grunt build"

alias today="cal | grep -C6 --color $(date +%e)"
