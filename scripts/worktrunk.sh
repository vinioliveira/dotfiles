#!/usr/bin/env bash

gw_has_worktrunk() {
  command -v wt >/dev/null 2>&1
}

gw_wt() {
  local repo_path=$1
  shift

  WORKTRUNK_CONFIG_PATH="$HOME/.dotfiles/worktrunk/config.toml" wt -C "$repo_path" "$@"
}

gw_branch_exists() {
  local repo_path=$1
  local branch=$2

  git -C "$repo_path" show-ref --verify --quiet "refs/heads/$branch" ||
    git -C "$repo_path" show-ref --verify --quiet "refs/remotes/origin/$branch"
}

gw_worktree_path_by_branch() {
  local repo_path=$1
  local branch=$2
  local path=""
  local current_branch=""

  while IFS= read -r line; do
    case "$line" in
      worktree\ *)
        path=${line#worktree }
        ;;
      branch\ refs/heads/*)
        current_branch=${line#branch refs/heads/}
        if [[ "$current_branch" == "$branch" ]]; then
          printf '%s\n' "$path"
          return 0
        fi
        ;;
      "")
        path=""
        current_branch=""
        ;;
    esac
  done < <(git -C "$repo_path" worktree list --porcelain)

  return 1
}

gw_pick_existing_worktree_branch() {
  local repo_path=$1

  git -C "$repo_path" worktree list --porcelain | awk '
    /^worktree / { path = substr($0, 10) }
    /^branch refs\/heads\// {
      branch = substr($0, 18)
      print branch "\t" path
    }
  ' | fzf --with-nth=1 --delimiter=$'\t' | cut -f1
}

gw_switch_and_cd() {
  local repo_path=$1
  local branch=$2
  local selected_branch=""
  local target_path=""

  if [[ -n "$branch" ]]; then
    selected_branch=$branch

    if gw_branch_exists "$repo_path" "$branch"; then
      gw_wt "$repo_path" switch --no-cd "$branch" || return 1
    else
      gw_wt "$repo_path" switch --create --no-cd "$branch" || return 1
    fi
  else
    selected_branch=$(gw_wt "$repo_path" switch --no-cd) || return 1
    [[ -n "$selected_branch" ]] || return 0

    gw_wt "$repo_path" switch --no-cd "$selected_branch" || return 1
  fi

  target_path=$(gw_worktree_path_by_branch "$repo_path" "$selected_branch") || return 1
  [[ -n "$target_path" ]] || return 1

  builtin cd "$target_path" || return 1
}
