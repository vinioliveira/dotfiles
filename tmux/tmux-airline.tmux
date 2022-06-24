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
MUSIC="#[bg=colour0]$(run_segment)"
fi
TIME="#[bg=colour0]#[fg=colour6]#[bg=colour6]#[fg=colour0] $(date +'%H:%M') #[fg=white]"
echo "$MUSIC $TIME" | sed 's/ *$/ /g'
