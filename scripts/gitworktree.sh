#!/usr/bin/env bash

source "$HOME/.dotfiles/scripts/worktrunk.sh"

GIT_WT_BASE_PATH=$1
BRANCH=$2

if gw_has_worktrunk; then
  if [[ -n "$BRANCH" ]]; then
    if gw_branch_exists "$GIT_WT_BASE_PATH" "$BRANCH"; then
      gw_wt "$GIT_WT_BASE_PATH" switch -x "${SHELL:-/bin/zsh}" "$BRANCH"
    else
      gw_wt "$GIT_WT_BASE_PATH" switch --create -x "${SHELL:-/bin/zsh}" "$BRANCH"
    fi
    exit $?
  fi

  gw_wt "$GIT_WT_BASE_PATH" switch -x "${SHELL:-/bin/zsh}"
  exit $?
fi

GIT_WT_REGEX='([^[:space:]]*).*\[(.*)\]$'
cd $GIT_WT_BASE_PATH
GWT_PATH=""

IFS=
while read line; do
  if [[ $line =~ $GIT_WT_REGEX ]]; then
    GWT_BRANCH="${BASH_REMATCH[2]}"
    if [[ $GWT_BRANCH = $BRANCH ]]; then
      GWT_PATH=${BASH_REMATCH[1]}
      break
    fi
  fi
done <<< $( git worktree list )


if [[ ! -z "$GWT_PATH" ]]; then
  cd $GWT_PATH
  exec $SHELL
fi

NORMALIZED_BRANCH=${BRANCH//\//\-}
GWT_PATH="$GIT_WT_BASE_PATH/branches/$NORMALIZED_BRANCH"

git fetch origin

git branch --all | grep $BRANCH >/dev/null
r=$?
if [[ "$r" == "0" ]]; then
  git worktree add $GWT_PATH $BRANCH
else
  git worktree add $GWT_PATH -b $BRANCH
fi
cd $GWT_PATH


# if copy-ai
if [[ "$GIT_WT_BASE_PATH" == *"copy-ai.git"* ]]; then
  # copy .env file
  cp $GIT_WT_BASE_PATH/branches/develop/.env .
fi


#if fullcast folder copy for apps
if [[ "$GIT_WT_BASE_PATH" == *"data-intelligence.git"* ]]; then
  # copy .env for all the packages and apps and paste them in their respective folders
  shopt -s nullglob
  for f in "$GIT_WT_BASE_PATH"/branches/main/packages/*/.env "$GIT_WT_BASE_PATH"/branches/main/apps/*/.env; do
    # Extract the relative path (e.g., "packages/foo" or "apps/graphrag-api")
    relative_path=$(echo "$f" | sed "s|$GIT_WT_BASE_PATH/branches/main/||" | sed 's|/.env$||')
    dest_dir="$GWT_PATH/$relative_path"
    if [ -d "$dest_dir" ]; then
      cp "$f" "$dest_dir/.env"
      echo "✓ Copied .env to $dest_dir"
    else
      echo "✗ Destination directory does not exist: $dest_dir"
    fi
  done
  shopt -u nullglob
fi


pnpm i

exec $SHELL
