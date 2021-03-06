#!/bin/sh

MEDIUM=140

if [ "${1}" -gt "$MEDIUM" ]; then
  run_segment() {
    local np=$(~/.dotfiles/tmux/spotify_mac.script)
    if [ -n "$np" ]; then
      np=${np:0:40}
      echo "♫ ${np}"
    fi
    return 0
  }
MUSIC="$(run_segment) #[fg=white]«"
fi
TIME="#[fg=colour4]$(date +'%H:%M') #[fg=white]"
echo "$MUSIC $TIME" | sed 's/ *$/ /g'
