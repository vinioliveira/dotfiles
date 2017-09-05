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
alias g='git'

alias t="tmux"
alias tn="tmuxp load"
alias tls="tmux ls"
alias tkill="tmux kill-session -t"
alias tlayout="tmux list-windows -F \"#{window_active} #{window_layout}\" | grep \"^1\" | cut -d \" \" -f 2"

alias today="cal | grep -C6 --color $(date +%e)"
