#!/usr/bin/env bash

BRANCH=$1

GIT_WT_BASE_PATH=~/dev/projects/copyai/copy-ai.git
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

# copy .env file
cp $GIT_WT_BASE_PATH/branches/develop/.env .
pnpm i

exec $SHELL
