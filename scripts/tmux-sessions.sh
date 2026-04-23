#!/usr/bin/env bash

set -euo pipefail

projects_config="$HOME/.dotfiles/config/projects.conf"
script_path="$HOME/.dotfiles/scripts/tmux-sessions.sh"

list_sessions() {
  local current
  current="$(tmux display-message -p '#S')"

  tmux list-sessions -F '#{session_activity}|#{session_name}|#{session_path}|#{session_windows}w / #{session_panes}p|#{?session_attached,(attached),}' \
    | sort -t'|' -k1,1nr \
    | awk -F'|' -v current="$current" '
        $2 != current { print $0 }
        $2 == current { current_line = $0 }
        END {
          if (current_line != "") {
            print current_line
          }
        }
      ' \
    | while IFS='|' read -r _activity name path info attached; do
        path="${path/$HOME/~}"
        printf "%s\t\033[1;33m%-20s\033[0m  \033[2m%-35s\033[0m  \033[32m%-14s\033[0m  \033[36m%s\033[0m\n" \
          "$name" "$name" "$path" "$info" "$attached"
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
          --header 'enter: choose  ctrl-b: back' \
          --expect=ctrl-b
}

pick_project() {
  awk '!/^#/ && NF { print $1 }' "$projects_config" \
    | fzf --border=double \
          --border-label=' open worktree ' \
          --color 'border:#6C7086,label:#CDD6F4' \
          --prompt ' project  ' \
          --header 'enter: choose  ctrl-b: back' \
          --expect=ctrl-b
}

project_path_by_name() {
  awk -v name="$1" '$1 == name { print $2 }' "$projects_config"
}

pick_worktree_branch() {
  local project_path="$1"
  local result key selection

  result="$(
    git -C "$project_path" worktree list | grep -v '(bare)' \
      | fzf --border=double \
            --border-label=' worktrees ' \
            --color 'border:#6C7086,label:#CDD6F4' \
            --prompt ' branch  ' \
            --header 'enter: open  ctrl-b: back' \
            --expect=ctrl-b
  )"

  key="$(sed -n '1p' <<< "$result")"
  selection="$(sed -n '2p' <<< "$result")"

  if [[ -z "$selection" && -n "$key" && "$key" != "ctrl-b" ]]; then
    selection="$key"
    key=""
  fi

  printf '%s\n' "$key"
  if [[ -n "$selection" ]]; then
    awk '{print $1}' <<< "$selection" | xargs -I{} basename "{}"
  fi
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
  local branch_result branch_key

  project_path="$(project_path_by_name "$project_name")"
  [[ -z "$project_path" ]] && return 1
  project_path="${project_path/#\~/$HOME}"

  if [[ -z "$branch_name" ]]; then
    branch_result="$(pick_worktree_branch "$project_path")"
    branch_key="$(sed -n '1p' <<< "$branch_result")"
    branch_name="$(sed -n '2p' <<< "$branch_result")"

    if [[ "$branch_key" == "ctrl-b" ]]; then
      return 2
    fi

    [[ -z "$branch_name" ]] && return 1
  fi

  exec "$HOME/.dotfiles/scripts/gitworktree.sh" "$project_path" "$branch_name"
}

if [[ "${1:-}" == "--list" ]]; then
  list_sessions
  exit 0
fi

result="$(
  list_sessions | fzf --ansi \
    --layout=default \
    --border=double \
    --border-label=' sessions ' \
    --color 'border:#6C7086,label:#CDD6F4,hl:underline,hl+:underline' \
    --delimiter=$'\t' \
    --with-nth=2 \
    --highlight-line \
    --prompt '  ' \
    --no-separator \
    --print-query \
    --expect=ctrl-n,ctrl-o \
    --header 'enter: switch  ctrl-n: create  ctrl-o: open branch  ctrl-x: kill' \
    --bind "ctrl-x:execute-silent(tmux kill-session -t {1})+reload($script_path --list)+transform-header(killed {1}  |  enter: switch  ctrl-n: create  ctrl-o: open branch  ctrl-x: kill)"
)"

query="$(sed -n '1p' <<< "$result")"
key="$(sed -n '2p' <<< "$result")"
selection="$(sed -n '3p' <<< "$result")"

if [[ -z "$selection" && -n "$key" && "$key" != ctrl-* ]]; then
  selection="$key"
  key=""
fi

if [[ "$key" == "ctrl-n" ]]; then
  target_result="$(pick_create_target)"
  target_key="$(sed -n '1p' <<< "$target_result")"
  target="$(sed -n '2p' <<< "$target_result")"

  if [[ -z "$target" && -n "$target_key" && "$target_key" != "ctrl-b" ]]; then
    target="$target_key"
    target_key=""
  fi

  if [[ "$target_key" == "ctrl-b" ]]; then
    exec "$script_path"
  fi

  [[ -z "$target" ]] && exit 0

  if [[ "$target" == "tmux session" ]]; then
    create_tmux_session "$query"
  else
    if ! create_project_session "$target" "$query"; then
      status=$?
      [[ "$status" -eq 2 ]] && exec "$script_path"
      exit 0
    fi
  fi

  exit 0
fi

if [[ "$key" == "ctrl-o" ]]; then
  project_result="$(pick_project)"
  project_key="$(sed -n '1p' <<< "$project_result")"
  project_name="$(sed -n '2p' <<< "$project_result")"

  if [[ -z "$project_name" && -n "$project_key" && "$project_key" != "ctrl-b" ]]; then
    project_name="$project_key"
    project_key=""
  fi

  if [[ "$project_key" == "ctrl-b" ]]; then
    exec "$script_path"
  fi

  [[ -z "$project_name" ]] && exit 0

  if ! create_project_session "$project_name"; then
    status=$?
    [[ "$status" -eq 2 ]] && exec "$script_path"
    exit 0
  fi

  exit 0
fi

session_name="${selection%%$'\t'*}"
[[ -n "$session_name" ]] && tmux switch-client -t "$session_name"
