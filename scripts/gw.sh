#!/usr/bin/env bash
CONFIG="$HOME/.dotfiles/config/projects.conf"

detect_project() {
  while read -r name path; do
    [[ "$name" == "#"* || -z "$name" ]] && continue
    local expanded="${path/#\~/$HOME}"
    if [[ "$PWD" == "$expanded"* ]]; then
      echo "$expanded"
      return 0
    fi
  done < "$CONFIG"
  return 1
}

pick_project() {
  local selected
  selected=$(grep -v '^#' "$CONFIG" | grep -v '^$' | awk '{print $1}' \
    | fzf --prompt ' project  ' \
          --border=double \
          --border-label=' select project ' \
          --color 'border:#6C7086,label:#CDD6F4')
  [[ -z "$selected" ]] && return 1
  local path
  path=$(awk -v name="$selected" '$1 == name {print $2}' "$CONFIG")
  echo "${path/#\~/$HOME}"
}

pick_worktree() {
  local project_path=$1
  local selected
  selected=$(git -C "$project_path" worktree list | grep -v '(bare)' \
    | fzf --border=double \
          --border-label=' worktrees ' \
          --color 'border:#6C7086,label:#CDD6F4' \
          --prompt '  ')
  [[ -z "$selected" ]] && return 1
  basename "$(echo "$selected" | awk '{print $1}')"
}

BRANCH=$1
PROJECT_PATH=$(detect_project) || PROJECT_PATH=$(pick_project) || exit 0

if [[ -z "$BRANCH" ]]; then
  BRANCH=$(pick_worktree "$PROJECT_PATH") || exit 0
fi

exec gitworktree.sh "$PROJECT_PATH" "$BRANCH"
