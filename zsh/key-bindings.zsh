# bindkey '^r' history-incremental-search-backward
fzf-open-file-or-dir() {
  local out=$(fzf --height 50% --reverse --exit-0 --preview 'cat {}')

  if [ -f "$out" ]; then
    $EDITOR "$out" < /dev/tty
  elif [ -d "$out" ]; then
    cd "$out"
    zle reset-prompt
  fi
}
zle     -N   fzf-open-file-or-dir
bindkey '^P' fzf-open-file-or-dir

