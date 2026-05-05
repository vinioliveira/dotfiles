#!/usr/bin/env bash

set -euo pipefail

projects_config="$HOME/.dotfiles/config/projects.conf"
script_path="$HOME/.dotfiles/scripts/tmux-sessions.sh"
fzf_color='bg:#100f0f,bg+:#1c1b1a,fg:#cecdc3,fg+:#f2f0e5,border:#6f6e69,label:#878580,gutter:#100f0f,hl:#d14d41,hl+:#d14d41,info:#879a39,prompt:#da702c,pointer:#da702c,marker:#da702c,spinner:#879a39,header:#b7b5ac'
session_name_color='\033[1;38;5;180m'
path_color='\033[38;5;247m'
info_color='\033[38;5;108m'
attached_color='\033[38;5;110m'
ansi_reset='\033[0m'

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
        printf "%s\t%b%-20s%b  %b%-35s%b  %b%-14s%b  %b%s%b\n" \
          "$name" \
          "$session_name_color" "$name" "$ansi_reset" \
          "$path_color" "$path" "$ansi_reset" \
          "$info_color" "$info" "$ansi_reset" \
          "$attached_color" "$attached" "$ansi_reset"
      done
}

pick_create_target() {
  {
    printf 'tmux session\n'
    awk '!/^#/ && NF { print $1 }' "$projects_config"
  } | fzf --border=double \
          --border-label=' create session ' \
          --color "$fzf_color" \
          --prompt ' type  ' \
          --header 'enter: choose  ctrl-b: back' \
          --expect=ctrl-b
}

pick_project() {
  awk '!/^#/ && NF { print $1 }' "$projects_config" \
    | fzf --border=double \
          --border-label=' open worktree ' \
          --color "$fzf_color" \
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
            --color "$fzf_color" \
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

  if [[ -z "$session_name" ]]; then
    session_name="$(
      true | fzf --disabled \
                 --border=double \
                 --border-label=' new session ' \
                 --color "$fzf_color" \
                 --prompt ' name  ' \
                 --header 'type name + enter' \
                 --no-info \
                 --print-query \
                 --pointer=' ' \
      | head -1
    )" || true
  fi

  [[ -z "$session_name" ]] && return
  tmux new-session -ds "$session_name"
  tmux switch-client -t "$session_name"
}

rename_tmux_session() {
  local session_name="$1"
  local new_name

  [[ -z "$session_name" ]] && return 1

  new_name="$(
    true | fzf --disabled \
               --border=double \
               --border-label=" rename: $session_name " \
               --color "$fzf_color" \
               --prompt ' name  ' \
               --header 'type new name + enter' \
               --no-info \
               --print-query \
               --pointer=' ' \
    | head -1
  )" || true

  [[ -z "$new_name" ]] && return 1

  tmux rename-session -t "$session_name" "$new_name"
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
    --color "$fzf_color" \
    --delimiter=$'\t' \
    --with-nth=2 \
    --highlight-line \
    --prompt '  ' \
    --no-separator \
    --print-query \
    --expect=ctrl-n,ctrl-o,ctrl-r \
    --header 'enter: switch  ctrl-n: create  ctrl-o: open branch  ctrl-r: rename  ctrl-x: kill' \
    --bind "ctrl-x:execute-silent(tmux kill-session -t {1})+reload($script_path --list)+transform-header(killed {1}  |  enter: switch  ctrl-n: create  ctrl-o: open branch  ctrl-r: rename  ctrl-x: kill)"
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
    if create_project_session "$target" "$query"; then
      :
    else
      [[ $? -eq 2 ]] && exec "$script_path"
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

  if create_project_session "$project_name"; then
    :
  else
    [[ $? -eq 2 ]] && exec "$script_path"
    exit 0
  fi

  exit 0
fi

if [[ "$key" == "ctrl-r" ]]; then
  session_name="${selection%%$'\t'*}"
  [[ -z "$session_name" ]] && exit 0
  rename_tmux_session "$session_name"
  exit 0
fi

session_name="${selection%%$'\t'*}"
[[ -n "$session_name" ]] && tmux switch-client -t "$session_name"
