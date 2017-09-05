alias ll="ls -Glahs"
alias ll="ls -Glahs"
alias ls="ls -G"
alias make="make -j2"
alias ni="lsof -i -Pn"
alias psgrep="ps aux | egrep -v egrep | egrep"

alias r="rails"
alias n="node"
alias v="vim"

alias redis="redis-server"
alias top="top -o cpu"

#Adding hub alias to git
alias git="hub"
alias g="git"


# Git Alias
alias ga="g a"
alias gaa="g aa"
alias gb="g bb"
alias gc="g c"
alias gco="g co"
alias gd="g d"
alias gm="g m"
alias gnb="g nb"
alias go="g o"
alias gop="g op"
alias gp="g p"
alias gpf="g pf"
alias gpr="g pr"
alias grename="g rename"
alias gs="g s"
alias gst="g st"
alias gup="g up"
alias gcoi="fbr"

alias t="tmux"
alias tn="tmuxp load"
alias tls="tmux ls"
alias tkill="tmux kill-session -t"
alias tlayout="tmux list-windows -F \"#{window_active} #{window_layout}\" | grep \"^1\" | cut -d \" \" -f 2"

alias today="cal | grep -C6 --color $(date +%e)"
