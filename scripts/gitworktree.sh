#!/usr/bin/env bash

set -euo pipefail

BACKGROUND=false
POSITIONAL=()

for arg in "$@"; do
  case "$arg" in
    --bg) BACKGROUND=true ;;
    *) POSITIONAL+=("$arg") ;;
  esac
done

GIT_WT_BASE_PATH="${POSITIONAL[0]}"
BRANCH="${POSITIONAL[1]}"

notify_terminal_pwd() {
  local host_name
  host_name="$(hostname -f 2>/dev/null || hostname)"
  printf '\033]7;file://%s%s\007' "$host_name" "$PWD"
}

# Create or switch to a tmux session for the worktree
tmux_session_for_worktree() {
  local session_name="${1//\./_}"
  session_name="${session_name//\//_}"

  if ! tmux has-session -t="$session_name" 2>/dev/null; then
    tmux new-session -ds "$session_name" -c "$PWD"
  fi

  if [[ "$BACKGROUND" == true ]]; then
    echo "tmux session '$session_name' created in background"
    return
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session_name"
  else
    tmux attach-session -t "$session_name"
  fi
}

cd "$GIT_WT_BASE_PATH"
GWT_PATH="$(git worktree list | awk -v branch="/branches/${BRANCH} " '$0 ~ branch { print $1 }')"

if [[ -n "$GWT_PATH" ]]; then
  cd "$GWT_PATH"
  notify_terminal_pwd
  tmux_session_for_worktree "$BRANCH"
  exit 0
fi

NORMALIZED_BRANCH=${BRANCH//\//\-}
GWT_PATH="$GIT_WT_BASE_PATH/branches/$NORMALIZED_BRANCH"

git fetch origin >/dev/null 2>&1 || true

if git show-ref --verify --quiet "refs/heads/$BRANCH" || git show-ref --verify --quiet "refs/remotes/origin/$BRANCH"; then
  git worktree add "$GWT_PATH" "$BRANCH"
else
  git worktree add "$GWT_PATH" -b "$BRANCH"
fi
cd "$GWT_PATH"


# if copy-ai
if [[ "$GIT_WT_BASE_PATH" == *"copy-ai.git"* ]]; then
  # copy .env file
  if [[ -f "$GIT_WT_BASE_PATH/branches/develop/.env" ]]; then
    cp "$GIT_WT_BASE_PATH/branches/develop/.env" .
  fi
fi


#if fullcast folder copy for apps
if [[ "$GIT_WT_BASE_PATH" == *"data-intelligence.git"* ]]; then
  find "$GIT_WT_BASE_PATH/branches/main/packages" "$GIT_WT_BASE_PATH/branches/main/apps" "$GIT_WT_BASE_PATH/branches/main/skills" \
    \( -path '*/node_modules/*' -o -path '*/local/*' \) -prune -o \
    -name .env -type f -print 2>/dev/null | while read -r f; do
      relative_path="${f#$GIT_WT_BASE_PATH/branches/main/}"
      dest_dir="$GWT_PATH/${relative_path%/.env}"
      if [ -d "$dest_dir" ]; then
        cp "$f" "$dest_dir/.env"
        echo "✓ Copied .env to $dest_dir"
      else
        echo "✗ Destination directory does not exist: $dest_dir"
      fi
    done
fi


pnpm i

notify_terminal_pwd
tmux_session_for_worktree "$BRANCH"
