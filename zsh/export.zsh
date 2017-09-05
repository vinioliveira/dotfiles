[ -n "$TMUX" ] && export TERM=screen-256color

export PATH=":$HOME/bin:/bin:/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/usr/X11/bin"
export INSTALL_DIR="$HOME/local"
export MANPATH=/usr/local/git/man:$MANPATH

export HISTCONTROL=ignoreboth
export HISTFILESIZE=1000000
export HISTSIZE=${HISTFILESIZE}
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
export CDHISTORY="/tmp/cd-${USER}"

export PATH="$HOME/.rbenv/bin:$PATH"
export NVM_DIR=$(brew --prefix)/var/nvm
export HOMEBREW_GITHUB_API_TOKEN="7d36c1a21ae5697228b2ec3d360ef9a10d2ffe34"
# export TERM=xterm-color
export TMUX_POWERLINE_SEG_NOW_PLAYING_MUSIC_PLAYER=spotify
export TODO_DB_PATH="$HOME/.todos"
