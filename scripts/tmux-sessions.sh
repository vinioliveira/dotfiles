#!/usr/bin/env bash

SESSION=$(
  current=$(tmux display-message -p '#S')
  sessions=$(tmux list-sessions -F '#{session_name}|#{session_path}|#{session_windows}w / #{session_panes}p|#{?session_attached,(attached),}')
  { echo "$sessions" | grep -v "^${current}|"; echo "$sessions" | grep "^${current}|"; } \
  | while IFS='|' read -r name path info attached; do
      path="${path/$HOME/~}"
      printf "\033[1;33m%-20s\033[0m  \033[2m%-35s\033[0m  \033[32m%-14s\033[0m  \033[36m%s\033[0m\n" \
        "$name" "$path" "$info" "$attached"
    done \
  | fzf --ansi \
        --layout=default \
        --border=double \
        --border-label=' sessions ' \
        --color 'border:#6C7086,label:#CDD6F4,hl:underline,hl+:underline' \
        --highlight-line \
        --prompt '  ' \
        --no-separator \
  | awk '{print $1}'
)

[[ -n $SESSION ]] && tmux switch-client -t "$SESSION"
