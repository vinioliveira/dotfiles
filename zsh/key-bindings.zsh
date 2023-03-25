vfzf() {
  local out=$(fzf-tmux --height 50% --reverse --exit-0 --preview 'cat {}')

  if [ -f "$out" ]; then
    $EDITOR "$out" < /dev/tty
  elif [ -d "$out" ]; then
    cd "$out"
    zle reset-prompt
  fi
}

