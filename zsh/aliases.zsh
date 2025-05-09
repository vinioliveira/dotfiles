alias ll="eza -la --icons --classify "
alias ls="eza --sort Name -F --icons"
alias make="make -j2"
alias ni="lsof -Pn -i"
alias psgrep="ps aux | egrep -v egrep | egrep"
alias k9="kill -9"
alias cat="bat"
alias cd="z"
alias cdi="zi"

function _zoxide_fzf() {
  cd "$(zoxide query --list | fzf)"
}
alias zz="_zoxide_fzf"

alias r="rails"
alias n="node"
alias v="nvim"

alias redis="redis-server"
alias mosquitto="mosquitto -c /usr/local/etc/mosquitto/mosquitto.conf"
alias mongod="mongod --config /usr/local/etc/mongod.conf --fork"
alias top="top -o cpu"

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
alias glog="g log"
alias gl="g log"
alias glg="g lg"
alias gp="g p"
alias gpf="g pf"
alias gop="gh browse"
alias gopr="gh pr view --web"
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
alias tls="tmux ls"
alias tkill="tmux kill-session -t"
alias tnew="tmux new-session -A -s"
alias tlayout="tmux list-windows -F \"#{window_active} #{window_layout}\" | grep \"^1\" | cut -d \" \" -f 2"

alias today="cal"

alias validate_pr="npm run format:check -- --base=origin/develop && npm run typecheck && npm run lint -- --base=origin/develop"
alias copyai_servers="copyai_server.sh"
alias gwco="gitworktree.sh"

alias darkmode="~/.dotfiles/scripts/swap-theme.sh dark"
alias lightmode="~/.dotfiles/scripts/swap-theme.sh light"
alias toggle-darkmode="~/.dotfiles/scripts/swap-theme.sh toggle"


alias yn="yarn"
alias np="npm"
alias pn="pnpm"
alias pi="pulumi"
alias tf="terraform"
