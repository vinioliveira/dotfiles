alias ll="exa -lFa --icons "
alias ls="exa --sort Name -F --icons"
alias make="make -j2"
alias ni="lsof -Pn -i"
alias psgrep="ps aux | egrep -v egrep | egrep"
alias k9="kill -9"
alias cat="bat"
alias cd="z"
alias cdi="zi"
alias zz="z -"

alias r="rails"
alias n="node"
alias v="nvim"

alias redis="redis-server"
alias mosquitto="mosquitto -c /usr/local/etc/mosquitto/mosquitto.conf"
alias mongod="mongod --config /usr/local/etc/mongod.conf --fork"
alias top="top -o cpu"

#Adding hub alias to git
eval "$(hub alias -s)"
# alias git="hub"
alias g="git"

alias ku="kubectl"
alias mku="minikube"


# Git Alias
alias ga="g a"
alias gaa="g aa"
alias gb="g b"
alias gbl="g bl"
alias gc="g c"
alias gco="g co"
alias gcp="g cp"
alias gpco="g pco"
alias gd="g d"
alias gm="g m"
alias gnb="g nb"
alias go="g o"
alias glog="g log"
alias gl="g log"
alias glg="g lg"
alias gp="g p"
alias gpf="g pf"
alias gop="g op"
alias gopr="g opr"
alias gops="g ops"
alias grename="g rename"
alias gs="g s"
alias gst="g st"
alias gup="g up"
alias gcoi="fbr"
alias gsync-master="g sync-master"
alias gwt="g wt"
alias gx="gitx ."

alias t="tmux"
alias tn="tmuxp load"
alias tls="tmux ls"
alias tkill="tmux kill-session -t"
alias tlayout="tmux list-windows -F \"#{window_active} #{window_layout}\" | grep \"^1\" | cut -d \" \" -f 2"

alias today="cal | grep -C6 --color $(date +%e)"

alias validate_pr="npm run format:check -- --base=origin/develop && npm run typecheck && npm run lint -- --base=origin/develop"
alias copyai_servers="copyai_server.sh"
alias gwco="gitworktree.sh"



alias yn="yarn"
alias np="npm"
alias pn="pnpm"

