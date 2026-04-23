#!/usr/bin/env bash

set -euo pipefail

projects_config="$HOME/.dotfiles/config/projects.conf"

list_sessions() {
  local current sessions
  current="$(tmux display-message -p '#S')"
  sessions="$(tmux list-sessions -F '#{session_name}|#{session_path}|#{session_windows}w / #{session_panes}p|#{?session_attached,(attached),}')"

  printf '%s\n' "$sessions" | awk -F'|' -v current="$current" '
    $1 != current { print }
    $1 == current { current_line = $0 }
    END {
      if (current_line != "") {
        print current_line
      }
    }
  ' | while IFS='|' read -r name path info attached; do
      path="${path/$HOME/~}"
      printf "\033[1;33m%-20s\033[0m  \033[2m%-35s\033[0m  \033[32m%-14s\033[0m  \033[36m%s\033[0m\n" \
        "$name" "$path" "$info" "$attached"
  done
}

pick_create_target() {
  {
    printf 'tmux session\n'
    awk '!/^#/ && NF { print $1 }' "$projects_config"
  } | fzf --border=double \
          --border-label=' create session ' \
          --color 'border:#6C7086,label:#CDD6F4' \
          --prompt ' type  ' \
          --header 'choose tmux session or project worktree'
}

project_path_by_name() {
  awk -v name="$1" '$1 == name { print $2 }' "$projects_config"
}

pick_worktree_branch() {
  git -C "$1" worktree list | grep -v '(bare)' \
    | fzf --border=double \
          --border-label=' worktrees ' \
          --color 'border:#6C7086,label:#CDD6F4' \
          --prompt ' branch  ' \
    | awk '{print $1}' \
    | xargs -I{} basename "{}"
}

create_tmux_session() {
  local session_name="${1:-}"

  if [[ -n "$session_name" ]]; then
    tmux new-session -ds "$session_name"
    tmux switch-client -t "$session_name"
    return
  fi

  tmux command-prompt -p "New session name:" "new-session -ds '%%' \; switch-client -t '%%'"
}

create_project_session() {
  local project_name="$1"
  local branch_name="${2:-}"
  local project_path

  project_path="$(project_path_by_name "$project_name")"
  [[ -z "$project_path" ]] && exit 0
  project_path="${project_path/#\~/$HOME}"

  if [[ -z "$branch_name" ]]; then
    branch_name="$(pick_worktree_branch "$project_path")"
  fi

  [[ -z "$branch_name" ]] && exit 0
  exec "$HOME/.dotfiles/scripts/gitworktree.sh" "$project_path" "$branch_name"
}

result="$(
  list_sessions | fzf --ansi \
    --layout=default \
    --border=double \
    --border-label=' sessions ' \
    --color 'border:#6C7086,label:#CDD6F4,hl:underline,hl+:underline' \
    --highlight-line \
    --prompt '  ' \
    --no-separator \
    --print-query \
    --expect=ctrl-n \
    --header 'enter: switch  ctrl-n: create'
)"

query="$(sed -n '1p' <<< "$result")"
key="$(sed -n '2p' <<< "$result")"
selection="$(sed -n '3p' <<< "$result")"

if [[ "$key" == "ctrl-n" ]]; then
  target="$(pick_create_target)"
  [[ -z "$target" ]] && exit 0

  if [[ "$target" == "tmux session" ]]; then
    create_tmux_session "$query"
  else
    create_project_session "$target" "$query"
  fi

  exit 0
fi

session_name="$(awk '{print $1}' <<< "$selection")"
[[ -n "$session_name" ]] && tmux switch-client -t "$session_name"
