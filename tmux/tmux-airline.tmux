#!/bin/sh

SEP=
SEPE=

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

  MUSIC="#[fg=colour7, bg=colour237, nounderscore]$SEP#[fg=colour239, bg=colour7 bold]$(run_segment)"
fi

TIME="#[fg=colour237,bg=colour7,nobold,noitalics]$SEP#[fg=colour208,bg=colour237,nobold,noitalics]$SEP#[fg=colour0,bg=colour208,nobold] $(date +'%H:%M') "

echo "$MUSIC $TIME" | sed 's/ *$/ /g'
