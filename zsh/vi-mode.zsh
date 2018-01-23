# set -o vi

export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
export KEYTIMEOUT=1

# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
pb-copy-region-as-kill-deactivate-mark () {
  zle copy-region-as-kill
  zle set-mark-command -n -1
  echo -n $CUTBUFFER | pbcopy
}
zle -N pb-copy-region-as-kill-deactivate-mark
bindkey -a "y" pb-copy-region-as-kill-deactivate-mark

pb-kill-whole-line () {
  zle kill-whole-line
  echo -n $CUTBUFFER | pbcopy
}
zle -N pb-kill-whole-line
bindkey -a "dd" pb-kill-whole-line

pb-yank () {
  CUTBUFFER=$(pbpaste)
  zle yank
}
zle -N pb-yank
bindkey -a  "p" pb-yank
